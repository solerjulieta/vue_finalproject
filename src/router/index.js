import Vue from 'vue'
import VueRouter from 'vue-router'
import PagInicio from '../views/Inicio.vue'
import DetalleLibros from '../views/DetalleLibros.vue'
import MisFavoritos from '../views/Favoritos.vue'
import RegistroUsuario from '../views/Registro.vue'
import IniciarSesion from '../views/IniciarSesion.vue'

Vue.use(VueRouter)

const routes = [
  {
    path: '/',
    name: 'PagInicio',
    component: PagInicio
  },
  {
    path: '/DetalleLibros/:id',
    name: 'DetalleLibros',
    component: DetalleLibros
  },
  {
    path: '/Favoritos',
    name: 'MisFavoritos',
    component: MisFavoritos
  },
  {
    path: '/Registro',
    name: 'RegistroUsuario',
    component: RegistroUsuario
  },
  {
    path: '/Iniciar-sesion',
    name: 'IniciarSesion',
    component: IniciarSesion
  }
]

const router = new VueRouter({
  routes
})

export default router
