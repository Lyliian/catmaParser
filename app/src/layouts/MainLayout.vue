<template>
  <q-layout view="lHh Lpr lFf">
    <q-header elevated>
      <q-toolbar>
        <q-btn flat label="CATMA Parser" to="/" no-caps square size="lg" class="q-pa-none" />

        <q-space />

        <!-- Composant de gestion du token -->
        <TokenManager />
      </q-toolbar>
    </q-header>

    <q-page-container>
      <router-view />
    </q-page-container>
  </q-layout>
</template>

<script setup>
import TokenManager from './tokenManager.vue'
</script>
