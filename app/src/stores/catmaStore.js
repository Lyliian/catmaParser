import { defineStore } from 'pinia'

export const useCatmaStore = defineStore('catma', {
  state: () => ({
    project: [],
    namespace: '',
  }),
})
