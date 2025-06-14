<script setup>
import {ref} from "vue";

const props = defineProps({
  documents: {
    type: Array,
    required: true
  }
});

const selectedDocument = ref(null);

//function to get the document by id
const getDocumentById = (id) => {
  if(!id) return [];
  return props.documents.find(doc => doc.id === id).annotations || [];
};

const columns = [
  { name: 'annotationCollectionName', label: 'Collection', field: 'annotationCollectionName', align: 'left' },
  { name: 'tagName', label: 'Tag', field: 'tagName', align: 'left', sortable: true, },
  { name: 'phrases', label: 'Phrases', field: 'phrases', align: 'left', sortable: true, width: '200px' }
];


const getPhrases = (phrases) => {
  return phrases.map(phrase => phrase.phrase).join(', ');
};
</script>

<template>
  <div>
    <q-select v-model="selectedDocument" :options="props.documents" label="Sélectionner un document" option-value="id" option-label="title" emit-value map-options />
    <q-table
      :rows="getDocumentById(selectedDocument)"
      :columns="columns"
      row-key="id">
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
