<template>
  <v-app>
    <v-app-bar
      color="primary"
      dark
      prominent
    >
      <v-app-bar-nav-icon @click.stop="drawer = !drawer"></v-app-bar-nav-icon>

      <v-toolbar-title tag="h1">Libroteca</v-toolbar-title>

    </v-app-bar>

    <v-navigation-drawer
      v-model="drawer"
      absolute
      temporary
      tag="nav"
    >
      <v-list
        nav
        dense
        tag="ul"
      >
        <v-list-item-group
          v-model="group"
          active-class="primary--text text--accent-4"
        >
          <v-list-item v-for="item in items" :key="item.titulo" :to="item.path" tag="li">
            <div id="li-items" @click="item.click ? item.click($event) : $router.push(item.path)">
              <v-list-item-action><v-icon>mdi-{{item.icono}}</v-icon></v-list-item-action>
              <v-list-item-content><v-list-item-title>{{item.titulo}}</v-list-item-title></v-list-item-content>
            </div>
          </v-list-item>

        </v-list-item-group>
      </v-list>
    </v-navigation-drawer>

    <v-main>
      <router-view/>
    </v-main>

    <v-footer
    color="primary"
    padless
  >
    <v-row
      justify="center"
      no-gutters
    >
      <v-col
        class="primary py-4 text-center white--text"
        cols="12"
      >
        {{ new Date().getFullYear() }} — <strong>Libroteca</strong>
      </v-col>
    </v-row>
  </v-footer>
  </v-app>
</template>

<script>
export default {
  name: 'App',

  data: () => ({
      items:[
        {
          titulo: 'Inicio',
          icono: 'home',
          path: '/'
        },
        {
          titulo: 'Favoritos',
          icono: 'heart',
          path: '/favoritos'
        },
        {
          titulo: 'Registro',
          icono: 'account-plus',
          path: '/registro'
        },
        {
          titulo: 'Iniciar Sesión',
          icono: 'account',
          path: '/iniciar-sesion'
        }
      ],
      drawer: false,
      group: null,
      estaAutenticado: false,
      mensajeLogoutExitoso: false,
  }),

  watch: {
    group () {
      this.drawer = false;
      this.actualizarRutas();
    },
  },

  mounted(){
    this.actualizarRutas();
    this.mensajeLogoutExitoso = this.$route.query.logoutExitoso === 'true';
  },
  methods: {
    actualizarRutas(){
        const estaAutenticado = localStorage.getItem('authData') !== null;

        this.items = estaAutenticado ? [
          {
            titulo: 'Inicio',
            icono: 'home',
            path: '/'
          },
          {
            titulo: 'Favoritos',
            icono: 'heart',
            path: '/favoritos'
          },
          {
            titulo: 'Cerrar Sesión',
            icono: 'logout',
            click: this.cerrarSesion,
          }
        ] : [
          {
            titulo: 'Inicio',
            icono: 'home',
            path: '/'
          },
          {
            titulo: 'Registro',
            icono: 'account-plus',
            path: '/registro'
          },
          {
            titulo: 'Iniciar Sesión',
            icono: 'account',
            path: '/iniciar-sesion'
          }
        ];

        this.$nextTick(() => {});
    },
    cerrarSesion(e){
      e.stopPropagation();
      localStorage.removeItem('authData');
      this.actualizarRutas();
      this.estaAutenticado = false;
      this.$router.push({path: '/', query:{logoutExitoso: true}});
      window.location.reload();
    }
  }
};
</script>

<style>
.v-toolbar__content{height: 56px !important;}

header{max-height: 60px;}

input[type="checkbox"]{display: none;}

input[type="checkbox"] + label{
    display: inline-block;
    width: 165px;
    height: 19px;
    padding-left: 30px;
    background: url(assets/unlike.png) no-repeat;
    cursor: pointer;
}

input[type="checkbox"]:checked + label{
    background:url(assets/full-like.png) no-repeat;
    height: 19px;
    width: 165px;
    padding-left: 30px;
}

.btnSubmit{margin-top: 1rem;}

#li-items{display: flex;}
</style>