<template>
    <v-container tag="section">
      <v-btn
      class="mx-2"
      fab
      dark
      small
      color="primary"
      @click="$router.push('/')"
    >
      <v-icon dark>
        mdi-arrow-left
      </v-icon>
    </v-btn>
        <v-row class="detalle-libro">
          <v-col sm="12" md="4" lg="2" xl="1">
            <img :src="libro.imagen" :alt="libro.titulo" /> 
          </v-col>
          <v-col sm="12" lg="8" xl="7">
            <h2>{{libro.titulo}}</h2>
            <p class="resaltar">Autora: <b>{{libro.autor}}</b></p>
            <p class="resaltar">Género: <b>{{ libro.clasificacion }}</b></p>
            <p>{{ libro.sinopsis }}</p>
          </v-col>             
        </v-row>

      <ComponenteForm :id="libro.libro_id" />
    </v-container>
</template>

<script>
import ComponenteForm from '../components/Componente-form';

export default {
  name: 'DetalleLibros',
  components: {
    ComponenteForm
  },
  data: function(){
    return{
      id: "",
      libro: {}
    }
  },
  mounted: function(){
    this.recuperarDatos();
  },
  methods:{
    recuperarDatos: function(){
      this.id = this.$route.params.id;

      fetch(`http://finalibroteca.000webhostapp.com/app/traerPorId.php?libro_id=${this.id}`)
      .then(response => response.json())
      .then(data => {
        if(data && data.length > 0){
          this.libro = data;
        } else {
          this.librosLocalStorage();
        }
      })
      .catch(error => {
        console.log('Error al obtener detalles del libro:', error);
        this.librosLocalStorage();
      })
    },
    librosLocalStorage: function(){
      let librosStorage = localStorage.getItem('libros');

      if(librosStorage){
        let libros = JSON.parse(librosStorage);
        let libro = libros.find(libro => libro.libro_id == this.id);

        if(libro){
          this.libro = libro;
          console.log("Se encontró en localStorage");
        } else {
          console.log("No se encontró en localStorage");
        }
      }else {
        console.log("No se encontró nada.");
      }
    }
  }
}
</script>

<style scoped>
   .detalle-libro{justify-content: space-around;}

   .detalle-libro p{font-size: .9rem;}

   .resaltar{
    font-size: 1rem;
    margin-bottom: .5rem;
  }
  .detalle-libro img{border-radius: 8px;}

   section{margin-top: 3rem;}

   section h2{margin-bottom: .5rem;}
   
   @media screen and (max-width: 600px){
    .detalle-libro{flex-direction: column;}
   }

   @media screen and (max-width: 959px){
    .detalle-libro div:first-of-type{text-align: center;}
   }
</style>
