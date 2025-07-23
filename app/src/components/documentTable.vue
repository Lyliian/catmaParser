<script setup>
import {ref, computed, onMounted} from "vue";

const props = defineProps({
  documents: {
    type: Array,
    required: true
  }
});

const selectedDocument = ref(null);
const phraseFilter = ref("");
const tagFilter = ref(null);

//function to get the document by id
const getDocumentById = (id) => {
  if(!id) return [];
  return props.documents.find(doc => doc.id === id).annotations || [];
};

const tagOptions = computed(() => {
  const rows = getDocumentById(selectedDocument.value);
  const tags = rows.map(row => row.tagName).filter(Boolean);
  return Array.from(new Set(tags))
    .sort((a, b) => a.localeCompare(b))
    .map(tag => ({ label: tag, value: tag }));
});

const filteredRows = computed(() => {
  let rows = getDocumentById(selectedDocument.value);
  if (phraseFilter.value) {
    rows = rows.filter(row => {
      if (!row.phrases || row.phrases.length === 0) return false;
      return row.phrases.some(phraseObj =>
        phraseObj.phrase.toLowerCase().includes(phraseFilter.value.toLowerCase())
      );
    });
  }
  if (tagFilter.value) {
    rows = rows.filter(row => row.tagName === tagFilter.value);
  }
  // Tri descendant par défaut sur phrases[0].startOffset
  rows = sortRowByOffset(rows);
  // Tri des phrases à l'intérieur de chaque annotation si un tag est sélectionné
  return rows;
});

const sortRowByOffset = (rows) => {
  return rows.sort((a, b) => {
    const offsetA = a.phrases?.[0]?.startOffset ?? -Infinity;
    const offsetB = b.phrases?.[0]?.startOffset ?? -Infinity;
    return offsetA - offsetB;
  });
}

const columns = [
  { name: 'annotationCollectionName', label: 'Collection', field: 'annotationCollectionName', align: 'left' },
  { name: 'tagName', label: 'Tag', field: 'tagName', align: 'left',  },
  { name: 'phrases', label: 'Phrases', field: 'phrases', align: 'left',sortable: true, width: '200px'},
];


const getPhrases = (phrases) => {
  return phrases.map(phrase => phrase.phrase).join(', ');
};

const customSort = (rows, sortBy, descending) => {
  const data = [...rows]

  if (sortBy !== 'phrases') {
    data.sort((a, b) => {
      const x = descending ? b : a
      const y = descending ? a : b

      if (sortBy === 'name') {
        // string sort
        return x[ sortBy ] > y[ sortBy ] ? 1 : x[ sortBy ] < y[ sortBy ] ? -1 : 0
      }
    })


  }
  data.sort((a, b) => {
    const x = descending ? b : a
    const y = descending ? a : b
    if (x.phrases[0].startOffset !== undefined && y.phrases[0].startOffset !== undefined) {
      return y.phrases[0].startOffset - x.phrases[0].startOffset;
    }

    return 0;
  });

  return data
}

onMounted(() => {
  if (props.documents && props.documents.length > 0) {
    selectedDocument.value = props.documents[0].id;
  }
});
</script>

<template>
  <div>
    <q-card-section class="q-px-none q-pt-none">
      <q-select outlined v-model="selectedDocument" :options="props.documents" label="Sélectionner un document" option-value="id" option-label="title" emit-value map-options />
    </q-card-section>
    <q-card-section class="row q-px-none q-pt-sm justify-between">
      <q-select outlined v-model="tagFilter" :options="tagOptions" label="Filtrer par tag" clearable emit-value map-options style="width: 40%" />
      <q-input outlined v-model="phraseFilter" label="Filtrer par phrase" clearable style="width: 40%" />
    </q-card-section>
    <q-table
      :rows="filteredRows"
      :columns="columns"
      :sort-method="customSort"
      binary-state-sort
      row-key="id"
      :pagination="{
        rowsPerPage: 10,
      }"
     >
      <template v-slot:body-cell-annotationCollectionName="props">
        <q-td :props="props">
          {{ props.row.annotationCollectionName }}
        </q-td>
      </template>
      <template v-slot:body-cell-tagName="props">
        <q-td :props="props">
          <span :style="{ backgroundColor: props.row.tagColor, color: '#fff', padding: '2px 8px', borderRadius: '4px', display: 'inline-block' }">
            {{ props.row.tagName }}
          </span>
        </q-td>
      </template>
      <template v-slot:body-cell-phrases="props">
        <q-td :props="props" class="phrase-cell">
          <span v-if="props.row.phrases.length === 0" class="text-caption">Aucune phrase</span>
          <span v-else class="phrase-content">
            {{getPhrases(props.row.phrases)}}

          </span>
        </q-td>
      </template>
    </q-table>
  </div>

</template>

<style scoped>
.phrase-cell {
  max-width: 400px;
  white-space: normal;
}

.phrase-content {
  word-wrap: break-word;
  word-break: break-word;
  display: block;
}
</style>
