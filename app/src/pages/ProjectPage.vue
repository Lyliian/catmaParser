<script setup>
import { ref, onMounted } from 'vue';
import { api } from 'src/boot/axios';
import { useCatmaStore } from 'src/stores/catmaStore';
import DocumentTable from "components/documentTable.vue";
const props = defineProps({
  projectId: {
    type: String,
    required: true
  }
});

const catmaStore = useCatmaStore();

const project = ref(null);

const getProject = async (projectId) => {
  try {
    const response = await api.get(`/projects/${catmaStore.namespace}/${projectId}/export?includeExtendedMetadata=false`);
    project.value = response.data;
  } catch (error) {
    console.error('Error fetching project data:', error);
  }
};

const getProjects = async () => {
  try {
    const response = await api.get('/projects');
    if (response.data.length > 0) {
      catmaStore.namespace = response.data[0].namespace; // Set the namespace from the first project
    }
  } catch (error) {
    console.error('Error fetching projects:', error);
  }
};

onMounted(async () => {
  if (!catmaStore.namespace) {
    await getProjects();
  }

  await getProject(props.projectId);
});


</script>

<template>
  <document-table :documents="project?.documents" />
</template>

<style scoped>

</style>
