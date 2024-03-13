<template>
 <section class="container">
    <h1>Mis favoritos</h1>
    <v-container>
        <v-row>
           <v-col xs="12" lg="3" v-for="x in fav" :key="x.libro_id">
                <v-card :class="x.libro_id % 2 == 0 ? 'par' : 'impar'">
                    <div class="d-flex flex-no-wrap justify-space-between">
                    <div>
                    <v-card-title>{{x.titulo}}</v-card-title>
                    <v-card-subtitle>{{x.autor}}</v-card-subtitle>
                    </div>
                    <v-avatar size="120"  tile class="ma-3">
                      <v-img :src="x.imagen" :alt="x.titulo"></v-img>
                    </v-avatar>
                    </div>
                </v-card>
           </v-col>
        </v-row>
    </v-container>
    <div v-show="bandera == true">
        <img src="../assets/estante.png" >
        <p>Aún no tenés libros en favoritos.</p>
    </div>
 </section>
</template>

<script>
  export default {
    name: 'MisFavoritos',

    data: function(){
      return{
        fav: [],
        bandera: false
      }
    },

    mounted:function(){
      this.mostrar_fav();
    },

    methods: {
      mostrar_fav:function(){
        let authData = localStorage.getItem('authData');
        if(!authData){
          console.log('No hay datos de autenticación almacenados.');
          return;
        }

        let usuarioId = JSON.parse(authData).usuario;

        let usuariosEnLS = JSON.parse(localStorage.getItem('usuarios')) || {};

        usuariosEnLS[usuarioId] = usuariosEnLS[usuarioId] || {};
        usuariosEnLS[usuarioId].favoritos = usuariosEnLS[usuarioId].favoritos || {};
        usuariosEnLS[usuarioId].resenias = usuariosEnLS[usuarioId].resenias || [];

        localStorage.setItem('usuarios', JSON.stringify(usuariosEnLS));

        if(usuarioId){
          fetch(`http://finalibroteca.000webhostapp.com/app/obtenerFavoritos.php?usuario_id=${usuarioId}`)
          .then((response) => response.json())
          .then((data) => {
            if(data){
              let usuariosEnLS = JSON.parse(localStorage.getItem('usuarios')) || {};
              usuariosEnLS[usuarioId] = usuariosEnLS[usuarioId] || {};
              usuariosEnLS[usuarioId].favoritos = usuariosEnLS[usuarioId].favoritos || {};
              let librosEnLS = JSON.parse(localStorage.getItem('libros')) || [];

              data.favoritos.forEach((favorito) => {
                usuariosEnLS[usuarioId].favoritos[favorito.libro_id] = true;
              });
              localStorage.setItem('usuarios', JSON.stringify(usuariosEnLS));

              let libroIds = Object.keys(usuariosEnLS[usuarioId].favoritos || {})

              this.fav = libroIds.map((libroId) => {
                let libroInfo = librosEnLS.find((libro) => {
                  return libro.libro_id.toString() === libroId.toString()
                })
                return libroInfo ? { ...libroInfo, libro_id: parseInt(libroId) } : null
              })

              if (this.fav.length === 0) {
                this.bandera = true
              }
              if (this.fav.length === 0) {
              this.bandera = true;
              }
            } else {
              let usuariosEnLS = JSON.parse(localStorage.getItem('usuarios')) || {};
              let librosEnLS = JSON.parse(localStorage.getItem('libros')) || [];
              
              let libroIds = Object.keys(usuariosEnLS[usuarioId].favoritos || {})

              this.fav = libroIds.map((libroId) => {
                let libroInfo = librosEnLS.find((libro) => {
                  return libro.libro_id.toString() === libroId.toString()
                })
                return libroInfo ? { ...libroInfo, libro_id: parseInt(libroId) } : null
              })

              if (this.fav.length === 0) {
                this.bandera = true
              }
            }
          })
          .catch(error => {
            console.error("Hubo un error al intentar obtener de la base:", error)
            let usuariosEnLS = JSON.parse(localStorage.getItem('usuarios')) || {};
              let librosEnLS = JSON.parse(localStorage.getItem('libros')) || [];
              
              let libroIds = Object.keys(usuariosEnLS[usuarioId].favoritos || {})

              this.fav = libroIds.map((libroId) => {
                let libroInfo = librosEnLS.find((libro) => {
                  return libro.libro_id.toString() === libroId.toString()
                })
                return libroInfo ? { ...libroInfo, libro_id: parseInt(libroId) } : null
              })

              if (this.fav.length === 0) {
                this.bandera = true
              }
          });
        } 
      }  
    }
  }
</script>

<style scoped>
  section{
    margin-top: 1rem;
    margin-bottom: 1rem;
    text-align: center;
  }
  .par{
    background-color: #7b82ee !important;
    color: white !important;
  }
  .impar{
    background-color: #3f51b5 !important;
    color: white !important;
  }
</style>