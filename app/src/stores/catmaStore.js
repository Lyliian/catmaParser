import { defineStore } from 'pinia'

export const useCatmaStore = defineStore('catma', {
  state: () => ({
    project: [],
    namespace: '',
    _token: '',
  }),

  getters: {
    token: (state) => {
      // Si le token n'est pas en state, le récupérer depuis localStorage
      if (!state._token) {
        const storedToken = localStorage.getItem('catma-token')
        if (storedToken) {
          state._token = storedToken
        }
      }
      return state._token
    }
  },

  actions: {
    setToken(newToken) {
      this._token = newToken
      if (newToken) {
        localStorage.setItem('catma-token', newToken)
      } else {
        localStorage.removeItem('catma-token')
      }
    },

    clearToken() {
      this._token = ''
      localStorage.removeItem('catma-token')
    }
  }
})
