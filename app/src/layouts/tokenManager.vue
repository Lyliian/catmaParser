<template>
  <q-btn-dropdown flat round icon="person" dropdown-icon="none">
    <q-list style="min-width: 300px">
      <q-item-label header>Gestion du token</q-item-label>

      <q-item>
        <q-item-section>
          <q-item-label>Token actuel :</q-item-label>
          <div class="row items-center q-mt-sm">
            <div class="col">
              <q-input
                :model-value="displayedToken"
                readonly
                dense
                outlined
                :type="showToken ? 'text' : 'password'"
                class="q-mr-sm"
              />
            </div>
            <div class="col-auto">
              <q-btn
                flat
                dense
                round
                :icon="showToken ? 'visibility_off' : 'visibility'"
                @click="toggleTokenVisibility"
              />
            </div>
          </div>
        </q-item-section>
      </q-item>

      <q-separator />

      <q-item clickable @click="resetToken">
        <q-item-section avatar>
          <q-icon name="refresh" />
        </q-item-section>
        <q-item-section>
          <q-item-label>Réinitialiser le token</q-item-label>
          <q-item-label caption>Changer de token d'accès</q-item-label>
        </q-item-section>
      </q-item>
    </q-list>
  </q-btn-dropdown>
</template>

<script setup lang="ts">
import { ref, computed } from 'vue'
import { useCatmaStore } from 'src/stores/catmaStore'
import { useRouter } from 'vue-router'

const catmaStore = useCatmaStore()
const router = useRouter()

// Variables pour l'affichage du token
const showToken = ref(false)

// Computed pour afficher le token avec des étoiles ou le vrai token
const displayedToken = computed(() => {
  const token = catmaStore.token
  if (!token) return ''
  return showToken.value ? token : '*'.repeat(token.length)
})

// Fonction pour basculer la visibilité du token
const toggleTokenVisibility = () => {
  showToken.value = !showToken.value
}

// Fonction pour réinitialiser le token
const resetToken = async () => {
  localStorage.clear();
  console.log(router.currentRoute.value);
  if(router.currentRoute.value.name !== 'index') {
    await router.push({ name: 'index' });
    window.location.reload();
  } else {
    window.location.reload();
  }
}

</script>

<style >
.q-btn-dropdown__arrow {
  display: none; /* Cacher la flèche du dropdown */
}
</style>
