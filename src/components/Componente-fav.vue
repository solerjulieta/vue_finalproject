<template>
<div class="btn-fav">
<input type="checkbox" :id="id" @change="fav" :checked="esCheck"  />
<label :for="id">Añadir a favorito</label>
</div>
</template>

<script>
  export default {
    name: 'ComponenteFavoritos',

    props: ['id'],

    computed: {
    esCheck: function(){
        let usuariosEnLS = localStorage.getItem('usuarios');
        if(!usuariosEnLS){
            return false;
        }

        usuariosEnLS = JSON.parse(usuariosEnLS);

        let usuarioId = this.getUsuarioIdFromLS();

        return usuarioId in usuariosEnLS && this.id in usuariosEnLS[usuarioId].favoritos;
    }
  },

  methods: {
    fav(e){
        var estado = e.target.checked;
        if(estado == true){
            this.aniadirFav({id: this.id});
        } else{
            this.quitarFav(this.id);
        }
    },

    getUsuarioIdFromLS(){
        let authData = localStorage.getItem('authData');
        if(authData){
            let usuario = JSON.parse(authData);
            return usuario.usuario;
        } else {
            console.log("No hay datos de autenticación almacenados.");
            return null;
        }
    },

    aniadirFav(datos){
        let usuarioId = this.getUsuarioIdFromLS();

        let libroFavorito = new FormData();
        libroFavorito.append('usuario_id', this.getUsuarioIdFromLS());
        libroFavorito.append('libro_id', datos.id);

        fetch('http://finalibroteca.000webhostapp.com/app/guardarFavorito.php', {
            method: 'POST',
            body: libroFavorito,
        })
        .then(response => response.json())
        .then(data => {
            console.log(data.mensaje);
            this.actualizarLocalStorage(usuarioId, datos.id, true);
        })
        .catch(error => {
            console.log('Error:', error);
        })
    },

    quitarFav(quitar){
        let usuarioId = this.getUsuarioIdFromLS();

        let libroFav = new FormData();
        libroFav.append('usuario_id', usuarioId);
        libroFav.append('libro_id', quitar);

        fetch('http://finalibroteca.000webhostapp.com/app/quitarFavorito.php', {
            method: 'POST',
            body: libroFav,
        })
        .then(response => response.json())
        .then(data => {
            console.log(data);
            this.actualizarLocalStorage(usuarioId, quitar, false);
        })
        .catch(error => {
            console.error("Hubo un error al intentar quitar de favoritos:", error);
        })
    },

    actualizarLocalStorage(usuarioId, libroId, esFav){
        let usuariosEnLS = localStorage.getItem('usuarios');
        if(!usuariosEnLS){
            usuariosEnLS = {};
        } else {
            usuariosEnLS = JSON.parse(usuariosEnLS);
        }

        if(!(usuarioId in usuariosEnLS)){
            usuariosEnLS[usuarioId] = { favoritos: {}, resenias: [] };
        }

        if(esFav){
            usuariosEnLS[usuarioId].favoritos[libroId] = true;
        } else {
            delete usuariosEnLS[usuarioId].favoritos[libroId];
        }

        localStorage.setItem('usuarios', JSON.stringify(usuariosEnLS));
    }
  }
}
</script>

<style>
   .btn-fav{
     display: flex;
     justify-content: center;
     margin-bottom: .6rem;
   }
</style>