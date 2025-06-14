<template>
  <q-page v-if="projects" class="flex flex-center">
    <q-card v-for="project in projects" class="my-card" :key="project.id" style="width: 350px; margin: 10px;">
      <q-card-section class="text-h6">
        {{project.name}}
      </q-card-section>
      <q-card-section>
        <p>{{project.description}}</p>
      </q-card-section>
      <q-card-actions align="right">
        <q-btn color="primary" label="Voir le récapitulatif" :to="'/project/'+project.id" />
      </q-card-actions>
    </q-card>
  </q-page>
  <q-page v-else>
    <q-spinner class="absolute-center" color="primary" size="50px" />
  </q-page>
</template>

<script setup>
import { ref, onMounted } from 'vue';
import {api} from 'src/boot/axios';
const projects = ref([]);
import { useCatmaStore } from 'src/stores/catmaStore';

const catmaStore = useCatmaStore();
onMounted(() => {
  api.get('/projects')
    .then((response) => {
      projects.value = response.data;
      if(response.data.length > 0) {
        catmaStore.namespace = response.data[0].namespace; // Assuming you want to set the namespace from the first project
      }
    })
    .catch((error) => {
      console.error('Error fetching data:', error);
    });
});

</script>
