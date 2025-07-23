<script setup>
import assetToken from 'src/assets/access_token.jpg';
import tokenCreate from 'src/assets/token_create.jpg';
</script>

<template>
  <q-page class="">
    <q-card class="my-card">
      <q-card-section>
        <div class="text-h2">Comment générer un token dans Catma</div>
      </q-card-section>
      <q-separator inset />
      <q-card-section>
        <p>
        Pour créer un token dans Catma, suivez les étapes ci-dessous :
        </p>
        <ol>
          <li>Connectez-vous à votre compte Catma.</li>
          <li>Accédez à la section "Mon profil" en cliquant sur l'icône utilisateur en haut à droite. (image 1)</li>
          <li>Dans le menu, sélectionnez "Get Access Token".</li>
          <li>Donnez un nom à votre token et définissez une date de fin. Cette date ne peut dépasser la limite des 3 mois. (image 2)</li>
          <li>Cliquez sur "Créer" pour générer le token.</li>
          <li>Copiez le token généré et conservez-le en lieu sûr.</li>
          <li>Réitérez la procédure une fois le token expiré.</li>
        </ol>
        <div class="row">
          <div class="col-6 text-center">
          <p class="text-caption">Image 1</p>
          <q-img
            :src="assetToken"
            alt="CATMA Token"
            class="q-mb-md"
            style="max-width: 90%; height: auto;"
          />

          </div>
          <div class="col-6  text-center">
          <p class="text-caption">Image 2</p>
          <q-img
            :src="tokenCreate"
            alt="Create Token"
            class="q-mb-md"
            style="max-width: 90%; height: auto;"
          />
          </div>
        </div>
      </q-card-section>
    </q-card>
  </q-page>

</template>


<style scoped>

</style>
