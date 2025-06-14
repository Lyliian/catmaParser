import { defineBoot } from '#q-app/wrappers'
import axios from 'axios'

// Be careful when using SSR for cross-request state pollution
// due to creating a Singleton instance here;
// If any client changes this (global) instance, it might be a
// good idea to move this instance creation inside of the
// "export default () => {}" function below (which runs individually
// for each client)
//const API_BASE_URL = import.meta.env.VITE_API_BASE_URL || 'https://app.catma.de/api/v1'
const API_TOKEN = import.meta.env.VITE_API_TOKEN || ''
const api = axios.create({
  baseURL: '/api',
  headers: {
    'Authorization': `Bearer ${API_TOKEN}`
    // Vous pouvez ajouter d'autres headers selon vos besoins
  }
})

export default defineBoot(({ app }) => {
  // for use inside Vue files (Options API) through this.$axios and this.$api

  app.config.globalProperties.$axios = axios
  // ^ ^ ^ this will allow you to use this.$axios (for Vue Options API form)
  //       so you won't necessarily have to import axios in each vue file

  app.config.globalProperties.$api = api
  // ^ ^ ^ this will allow you to use this.$api (for Vue Options API form)
  //       so you can easily perform requests against your app's API
})


export { api }
