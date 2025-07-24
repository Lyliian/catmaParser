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

  <!-- Dialog persistante pour saisir le token -->
  <q-dialog v-model="showTokenDialog" persistent>
    <q-card style="min-width: 400px">
      <q-card-section>
        <div class="text-h6">Token requis</div>
      </q-card-section>

      <q-card-section class="q-pt-none">
        <p>Veuillez saisir votre token <span class="text-italic">Catma</span> pour accéder à vos projets :</p>
        <q-input v-model="tokenInput" filled :type="isPwd ? 'password' : 'text'"
                 label="Token"
                 outlined
                 :error="tokenError"
                 error-message="Le token doit contenir au moins 3 caractères"
                 @keyup.enter="validateAndSaveToken">
          <template v-slot:append>
            <q-icon
              :name="isPwd ? 'visibility_off' : 'visibility'"
              class="cursor-pointer"
              @click="isPwd = !isPwd"
            />
          </template>
        </q-input>
        <span class="">Pour créer un token vous pouvez suivre <q-btn to="/howto" flat dense no-caps color="info" class="q-pa-none" target="_blank">ce tutoriel</q-btn>.</span>
      </q-card-section>
      <q-card-section class="q-pt-none q-ma-none">
        <div class="row">
         <div class="col-1 content-center">
           <q-icon name="info" size="md"></q-icon>
         </div>
          <div class="col-11">
            <span class="text-italic">Catma parser</span> ne conserve aucun token. Les données reçues de vos projets <span class="text-italic">Catma</span> ne sont pas et ne seront jamais conservées sur nos serveurs.
          </div>
        </div>

      </q-card-section>
      <q-card-actions align="right">
        <q-btn color="primary" label="Valider" @click="validateAndSaveToken" />
      </q-card-actions>
    </q-card>
  </q-dialog>
</template>

<script setup>
import { ref, onMounted, computed } from 'vue';
import {api} from 'src/boot/axios';
const projects = ref([]);
import { useCatmaStore } from 'src/stores/catmaStore';

const catmaStore = useCatmaStore();

// Variables pour la dialog du token
const showTokenDialog = ref(false);
const tokenInput = ref('');
const tokenError = ref(false);
const isPwd = ref(true);

// Computed pour vérifier si on doit afficher la dialog
const shouldShowTokenDialog = computed(() => {
  return !catmaStore.token || catmaStore.token.trim() === '';
});

// Fonction pour valider et sauvegarder le token
const validateAndSaveToken = () => {
  // Réinitialiser l'erreur
  tokenError.value = false;

  // Validation stricte : vérifier que le token n'est pas vide, null, undefined ou composé uniquement d'espaces
  if (!tokenInput.value || typeof tokenInput.value !== 'string' || tokenInput.value.trim() === '') {
    tokenError.value = true;
    return;
  }

  // Validation supplémentaire : vérifier que le token a au moins 3 caractères
  if (tokenInput.value.trim().length < 3) {
    tokenError.value = true;
    return;
  }

  tokenError.value = false;
  catmaStore.setToken(tokenInput.value.trim());
  showTokenDialog.value = false;

  // Charger les projets après avoir défini le token
  loadProjects();
};

// Fonction pour charger les projets
const loadProjects = () => {
  api.get('/projects')
    .then((response) => {
      projects.value = response.data;
      if(response.data.length > 0) {
        catmaStore.namespace = response.data[0].namespace;
      }
    })
    .catch((error) => {
      console.error('Error fetching data:', error);
    });
};

onMounted(() => {
  if(shouldShowTokenDialog.value) {
    showTokenDialog.value = true;
  } else {
    loadProjects();
  }
});
</script>
