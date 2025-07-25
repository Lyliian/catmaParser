const routes = [
  {
    path: '/',
    component: () => import('layouts/MainLayout.vue'),
    children: [
      { path: '', component: () => import('pages/IndexPage.vue'), name: 'index' },
      { path: '/howto', component: () => import('pages/howTo.vue'), name: 'howto' },
      { path: '/project/:projectId', component: () => import('pages/ProjectPage.vue'), props: true, name: 'project' },
    ]
  },

  // Always leave this as last one,
  // but you can also remove it
  {
    path: '/:catchAll(.*)*',
    component: () => import('pages/ErrorNotFound.vue')
  }
]

export default routes
