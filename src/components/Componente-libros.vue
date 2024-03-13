<template>
<v-container>
  <v-row>
    <v-col sm="6" md="4" lg="3" xl="2" no-gutters v-for="item in libros" :key="item.id">
       <v-card>
         <v-img :src="item.imagen" :alt="item.titulo"></v-img>
         <v-card-title tag="h2">{{item.titulo}}</v-card-title>
         <v-card-subtitle tag="p">{{item.autor}}</v-card-subtitle>
        <template v-if="estaAutenticado">
         <ComponenteFavoritos :id="item.libro_id" />
        </template>
         <v-card-actions>
            <router-link class="btn" :to="'/DetalleLibros/' + item.libro_id">Ver Sinopsis</router-link>
         </v-card-actions>
       </v-card>
    </v-col>
  </v-row>
</v-container>
</template>

<script>
import ComponenteFavoritos from '../components/Componente-fav';

export default {
  name: 'ComponenteLibros',
  components:{
    ComponenteFavoritos
    },
  data(){
      return{
        libros:[],
        resenias: [], 
        estaAutenticado: false,
      }
  },
  mounted(){
    this.actualizarAutenticacion();

    fetch('http://finalibroteca.000webhostapp.com/app/todoslibros.php')
    .then(response => response.json())
    .then(response => {
      this.libros = response;
      localStorage.setItem("libros", JSON.stringify(this.libros))
    })
    .catch(err => console.error(err),
      this.libros = JSON.parse(localStorage.getItem("libros"))
    )

    fetch('http://finalibroteca.000webhostapp.com/app/todasResenias.php')
    .then(response => response.json())
    .then(response => {
      this.resenias = response;
      let usuarios = JSON.parse(localStorage.getItem('usuarios')) || {};

      this.resenias.forEach(resenia => {
        if(!usuarios[resenia.usuario_id]){
          usuarios[resenia.usuario_id] = { favoritos: {}, resenias: [] };
        }
        let existeResenia = usuarios[resenia.usuario_id].resenias.some(
          reseniaExistente => reseniaExistente.resenia_id === resenia.resenia_id
        );
        if(!existeResenia){
          usuarios[resenia.usuario_id].resenias.push(resenia);
        }
      });
      localStorage.setItem('usuarios', JSON.stringify(usuarios));
    })
    .catch(err => {
      console.log("Trayendo datos desde local storage:", err);
      let usuarios = JSON.parse(localStorage.getItem('usuarios')) || {};
      this.resenias = usuarios.resenias || [];
    })

    this.$root.$on('sesionCerrada', this.actualizarAutenticacion);
  },
  methods:{
    actualizarAutenticacion(){
      this.estaAutenticado = localStorage.getItem('authData') !== null;
    }
  }
}
</script>

<style>
.v-image{
  width: 60%;
  margin: auto;
}

.v-application p{margin-bottom: 0;}

.btn {
    display: inline-block;
    padding: 8px 16px; 
    color: white !important;
    font-weight: bold;
    background-color: #3f51b5 !important;
    border-color: #3f51b5;
    border-radius: 4px; 
    box-shadow: 0px 3px 5px -1px rgba(0, 0, 0, 0.2), 0px 6px 10px 0px rgba(0, 0, 0, 0.14), 0px 1px 18px 0px rgba(0, 0, 0, 0.12);
    transition: background-color 0.3s, box-shadow 0.3s;
    text-decoration: none;
    margin-bottom: 1rem;
    margin-top: 0;
  }

  .btn:hover {
    background-color: #767fb5d5;
    box-shadow: 0px 3px 5px -1px rgba(0, 0, 0, 0.2), 0px 6px 10px 0px rgba(0, 0, 0, 0.14), 0px 1px 18px 0px rgba(0, 0, 0, 0.12);
  }
.v-card__subtitle{text-align: center;}

.v-card__title, .v-card__actions{justify-content: center;}
</style>