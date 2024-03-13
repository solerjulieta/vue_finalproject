<template>
  <section>
    <ComponenteAlerta
      :mostrar="mostrarAlerta"
      :tipo="tipoAlerta"
      :mensaje="mensajeAlerta"
      @cerrar="mostrarAlerta = false"
    />
    <Componente-libros />
  </section>
</template>

<script>
  import ComponenteLibros from '../components/Componente-libros'
  import ComponenteAlerta from '../components/Componente-alerta';

  export default {
    name: 'PagInicio',
    data: function(){
      return{
        loginExitoso: false,
        logoutExitoso: false,
        mostrarAlerta: false,
        tipoAlerta: '',
        mensajeAlerta: '',
      }
    },
    components: {
      ComponenteLibros,
      ComponenteAlerta,
    },
    mounted: function(){
      let params = new URLSearchParams(this.$route.query);

      if(params.get('loginExitoso') === 'true'){
        this.mostrarAlerta = true;
        this.tipoAlerta = 'success';
        this.mensajeAlerta = '¡Bienvenido/a!';
      } else if(params.get('logoutExitoso') === 'true'){
        this.mostrarAlerta = true;
        this.tipoAlerta = 'success';
        this.mensajeAlerta = 'Cerraste Sesión.';
      }
    },
  }
</script>

<style scoped>
   section{
    margin-top: 1rem;
    margin-bottom: 1rem;
   }

   #alert{max-width: 230px;}
</style>