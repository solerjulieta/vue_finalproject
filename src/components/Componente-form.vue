<template>
<aside>
    <ComponenteAlerta
      :mostrar="mostrarAlerta"
      :tipo="tipoAlerta"
      :mensaje="mensajeAlerta"
      @cerrar="mostrarAlerta = false"
    />
    <v-divider></v-divider>
    <template v-if="estaAutenticado">
    <h3>¿Ya leíste este libro? ¡Escribí tu reseña!</h3>
    <p>¡Se prohíben spoilers!</p>
    <v-form v-on:submit.prevent="enviar" novalidate>
        <v-radio-group
        v-model="opcRecomendar"
        row
        >
            <v-radio
                label="Recomiendo"
                value="si"
            ></v-radio>
            <v-radio
                label="No recomiendo"
                value="no"
            ></v-radio>
        </v-radio-group>
        <span v-show="enviado===true && !opcRecomendar"><svg-icon type="mdi" :path="alert"></svg-icon>Debés indicar si lo recomendás o no.</span>
        <v-textarea
           v-model.trim="comentario"
           label="Reseña"
           rows="2"
           required
        >
        </v-textarea>
        <span v-show="enviado===true && !comentario"><svg-icon type="mdi" :path="alert"></svg-icon>La reseña es requerida. ¡Tu opinión nos interesa!</span>
        <v-btn
           color="primary"
           type="submit"
           class="btnSubmit"
        >
            Enviar
        </v-btn>
    </v-form>
    </template>
    <template v-else>
        <span id="usDeslogueado">* Para poder hacer tu reseña, debés <router-link to="/Registro">Registrarte</router-link> y/o <router-link to="/Iniciar-sesion">Iniciar Sesión</router-link>.</span>
    </template>
    <v-divider></v-divider>
<v-container>
    <h2>Reseñas:</h2>
    <p id="sinresenia" v-if="!tieneResenias && !cargandoResenias">Aún no hay reseñas de este libro.</p>
     <div v-for="(x, index) in resenia" :key="index">
        <v-row v-if="x.libro_id === id" class="comentarios animate__animated animate__fadeInLeft">
            <v-col sm="2" md="1" >
            <v-avatar color="indigo">
                <v-icon dark>
                    mdi-account-circle
                </v-icon>
            </v-avatar>
            </v-col>
            <v-col v-if="editarResenia === index">
                <v-form>
                    <v-radio-group
                    v-model="opcRecomendarEditado"
                    row
                    >
                        <v-radio
                            label="Recomiendo"
                            value="si"
                        ></v-radio>
                        <v-radio
                            label="No recomiendo"
                            value="no"
                        ></v-radio>
                    </v-radio-group>
                    <v-textarea v-model="comentarioEditado" label="Editar reseña" rows="2"></v-textarea>
                    <v-btn @click="cancelarEdicion">Cancelar</v-btn>
                    <v-btn color="primary" @click="guardarEdicion">Guardar</v-btn>
            </v-form>
            </v-col>
            <v-col v-else>
            <p class="fechaResenia">{{ formatearFecha(x.fecha_publicacion) }}</p>
            <p :class="x.recomiendo == 'si' ? 'green' : 'red'">{{x.recomiendo === 'si' ? 'Recomiendo' : 'No recomiendo'}} <v-icon v-if="x.recomiendo === 'si'">mdi-thumb-up</v-icon> <v-icon v-else>mdi-thumb-down</v-icon></p>
            <p>"{{x.comentario}}"</p>
            <template v-if="x.usuario_id === usuarioActual">
                <v-btn color="error" @click="abrirModal(index)"><svg-icon type="mdi" :path="trash"></svg-icon></v-btn>
                <v-btn color="accent" @click="editar(index)"><svg-icon type="mdi" :path="pencil"></svg-icon></v-btn>
            </template>
            </v-col>  
         </v-row>
     </div>
     <ComponenteModal 
        ref="modalComponent" 
        :reseniaSeleccionada="reseniaSeleccionada" 
        :resenia="resenia" 
        @eliminar-resenia="eliminarResenia"
        @update:reseniaSeleccionada="updateReseniaSeleccionada" 
        @update:resenia="actualizarResenia"
     />
</v-container>
</aside>
</template>

<script>
import ComponenteModal from './Componente-modal';
import ComponenteAlerta from './Componente-alerta';
import SvgIcon from '@jamescoyle/vue-icon';
import { mdiTrashCan, mdiPencil, mdiAlertCircle } from '@mdi/js';
import { v4 as generarUUID } from 'uuid';

export default {
    name: 'ComponenteForm',
    props: ['id'],
    components: {
        ComponenteModal,
        ComponenteAlerta,
        SvgIcon
    },
    data: function(){
        return{
            comentario: "",
            opcRecomendar: null,
            resenia: [],
            enviado: false,
            tieneResenias: false,
            trash: mdiTrashCan,
            pencil: mdiPencil,
            alert: mdiAlertCircle,
            reseniaSeleccionada: null,
            editarResenia: null,
            reseniaEnEdicion: null,
            comentarioEditado: '',
            opcRecomendarEditado: '',
            usuarioActual: null,
            cargandoResenias: false,
            mostrarAlerta: false,
            tipoAlerta: '',
            mensajeAlerta: '',
        }
    },
    computed: {
        estaAutenticado(){
            let authData = localStorage.getItem('authData');
            return authData;
        }
    },
    methods: {
        verificarResenias: function(){
            let libroId = this.id;
            this.tieneResenias = this.resenia.some(x => x.libro_id === libroId);
        },
        obtenerResenias: function(){
            this.cargandoResenias = true;
            fetch(`http://finalibroteca.000webhostapp.com/app/obtenerResenias.php?libro_id=${this.id}`)
            .then(response => response.json())
            .then(data => {
                if (data && data.length > 0){
                    this.resenia = data;
                } else {
                    const usuariosEnLS = JSON.parse(localStorage.getItem('usuarios')) || {};
                    const todasResenias = Object.values(usuariosEnLS).reduce((acumulador, usuario) => {
                        if(usuario.resenias){
                            acumulador.push(...usuario.resenias);
                        }
                        return acumulador;
                    }, []);

                    this.resenia = todasResenias.filter(resenia => resenia.libro_id === this.id);
                    this.cargandoResenias = false;
                }
                this.verificarResenias();
            })
            .catch(error => {
                console.log('Hubo un error al intentar obtener reseñas de la base de datos:', error);

                const usuariosEnLS = JSON.parse(localStorage.getItem('usuarios')) || {};
                const todasResenias = Object.values(usuariosEnLS).reduce((acumulador, usuario) => {
                if (usuario.resenias) {
                    acumulador.push(...usuario.resenias);
                }
                return acumulador;
                }, []);

                this.resenia = todasResenias.filter(resenia => resenia.libro_id === this.id);

                this.cargandoResenias = false;

                this.verificarResenias();
            })
        },
        abrirModal:function(index){
            this.reseniaSeleccionada = index;
            this.$refs.modalComponent.abrirModal(this.getUsuarioIdFromLS());
        },
        getUsuarioIdFromLS(){
            let authData = localStorage.getItem('authData');
            if(authData){
                let usuario = JSON.parse(authData);
                return usuario.usuario.toString();
            } else {
                console.log("No hay datos de autenticación almacenados.");
                return null;
            }
        },
        enviar:function(){
            this.enviado = true;
            if(this.opcRecomendar && this.comentario){
                this.agregarResenia();
            } else {
                this.mostrarAlerta = true;
                this.tipoAlerta = 'error';
                this.mensajeAlerta = 'Debes completar todos los campos para dejar tu reseña.';
            }
        },
        agregarResenia: function(){
            let usuarioId = this.getUsuarioIdFromLS();

            let reseniaId = generarUUID(); 

            let nuevaResenia = {
                resenia_id: reseniaId,
                usuario_id: usuarioId,
                libro_id: this.id,
                recomiendo: this.opcRecomendar,
                comentario: this.comentario,
                fecha_publicacion: new Date(),
            }

            let fechaFormateada = new Date().toLocaleDateString('es-ES', {
                year: 'numeric',
                month: '2-digit',
                day: '2-digit'
            }) + ' ' + new Date().toLocaleTimeString('es-ES', {
                hour: '2-digit',
                minute: '2-digit',
                second: '2-digit'
            });

            fechaFormateada = fechaFormateada.replace(/(\d+)\/(\d+)\/(\d+)(.+)/, '$3-$2-$1$4');

            nuevaResenia.fecha_publicacion = fechaFormateada;

            let recomendacion = new FormData();
            recomendacion.append('resenia_id', reseniaId);
            recomendacion.append('usuario_id', usuarioId);
            recomendacion.append('libro_id', this.id);
            recomendacion.append('recomiendo', this.opcRecomendar);
            recomendacion.append('comentario', this.comentario);

            fetch('http://finalibroteca.000webhostapp.com/app/agregarResenia.php', {
                method: 'POST',
                body: recomendacion,
            })
            .then(response => response.text())
            .then(data => {
                console.log(data);
                this.mostrarAlerta = true;
                this.tipoAlerta = 'success';
                this.mensajeAlerta = '¡Tu reseña se agregó con éxito!';

                let usuariosEnLS = JSON.parse(localStorage.getItem('usuarios')) || {};

                if(!(usuarioId in usuariosEnLS)){
                    usuariosEnLS[usuarioId] = {
                        favoritos: {},
                        resenias: [],
                    }
                }

                usuariosEnLS[usuarioId].resenias.push(nuevaResenia);

                localStorage.setItem('usuarios', JSON.stringify(usuariosEnLS));

                this.resenia.push(nuevaResenia);

                this.enviado = false;
                this.opcRecomendar = "";
                this.comentario = "";
            })
            .catch(error => {
                console.log('Error:', error);
                this.mostrarAlerta = true;
                this.tipoAlerta = 'error';
                this.mensajeAlerta = 'Ocurrió un error al intentar guardar tu reseña.';
            })
                
            if(this.opcRecomendar && this.comentario){
                this.enviado = false;
                this.opcRecomendar = "";
                this.comentario = "";
            }
        },
        updateReseniaSeleccionada(newValue) {
            this.reseniaSeleccionada = newValue;
        },
        actualizarResenia(nuevaResenia){
            this.resenia = nuevaResenia;
        },
        editar: function(index){
            this.editarResenia = index;
            this.reseniaEnEdicion = { ...this.resenia[index] };
            this.comentarioEditado = this.resenia[index].comentario;
            this.opcRecomendarEditado = this.resenia[index].recomiendo;
        },
        cancelarEdicion: function(){
            this.editarResenia = null;
        },
        guardarEdicion: function(){
            if(this.editarResenia !== null){
                let usuarioId = this.getUsuarioIdFromLS();
                let usuariosEnLS = JSON.parse(localStorage.getItem('usuarios')) || {};

                if(usuarioId in usuariosEnLS){
                    let reseniaEditada = [...this.resenia];
                    let reseniaId = this.resenia[this.editarResenia].resenia_id;

                    reseniaEditada[this.editarResenia].comentario = this.comentarioEditado;
                    reseniaEditada[this.editarResenia].recomiendo = this.opcRecomendarEditado;

                    let recomendacionEditada = new FormData();
                    recomendacionEditada.append('resenia_id', reseniaId);
                    recomendacionEditada.append('usuario_id', usuarioId);
                    recomendacionEditada.append('libro_id', this.id);
                    recomendacionEditada.append('recomiendo', this.opcRecomendarEditado);
                    recomendacionEditada.append('comentario', this.comentarioEditado);

                    fetch('http://finalibroteca.000webhostapp.com/app/editarResenia.php', {
                        method: 'POST',
                        body: recomendacionEditada,
                    })
                    .then(response => response.text())
                    .then(data => {
                        console.log('La reseña fue editada con éxito:', data);
                        this.mostrarAlerta = true;
                        this.tipoAlerta = 'success';
                        this.mensajeAlerta = '¡Tu reseña fue editada con éxito!';
                        this.usuarioActual = usuarioId;

                        usuariosEnLS[usuarioId].resenias = usuariosEnLS[usuarioId].resenias.map(resenia => {
                            if(resenia.resenia_id === reseniaId){
                                return {
                                    ...resenia,
                                    comentario: this.comentarioEditado,
                                    recomiendo: this.opcRecomendarEditado,
                                }
                            }
                            return resenia;
                        });

                        this.reseniaEnEdicion = null;

                        localStorage.setItem('usuarios', JSON.stringify(usuariosEnLS));
                    })
                    .catch(error => {
                        console.error('Error al editar la reseña:', error);
                        this.mostrarAlerta = true;
                        this.tipoAlerta = 'error';
                        this.mensajeAlerta = 'Ocurrió un error al intentar editar tu reseña.';
                        if (this.reseniaEnEdicion) {
                            this.resenia.splice(this.editarResenia, 1, { ...this.reseniaEnEdicion });
                            this.reseniaEnEdicion = null;
                        }
                    })
                }

                this.editarResenia = null;
            }
        },
        eliminarResenia: function(){
            if(this.reseniaEditada !== null){
                let usuarioId = this.getUsuarioIdFromLS();
                let usuariosEnLS = JSON.parse(localStorage.getItem('usuarios')) || {};

                if(usuarioId in usuariosEnLS && 'resenias' in usuariosEnLS[usuarioId]){
                    let reseniaId = this.resenia[this.reseniaSeleccionada].resenia_id;
                    let libroId = this.id;

                    let dataId = new FormData();
                    dataId.append('resenia_id', reseniaId);
                    dataId.append('libro_id', libroId);
                    dataId.append('usuario_id', usuarioId);

                    fetch('http://finalibroteca.000webhostapp.com/app/eliminarResenia.php', {
                        method: 'POST',
                        body: dataId
                    })
                    .then(response => response.json())
                    .then(data => {
                        console.log('La reseña fue eliminada con éxito:', data);
                        this.mostrarAlerta = true;
                        this.tipoAlerta = 'success';
                        this.mensajeAlerta = 'Eliminaste tu reseña.';

                        usuariosEnLS[usuarioId].resenias = usuariosEnLS[usuarioId].resenias.filter(resenia => resenia.resenia_id !== reseniaId);

                        localStorage.setItem('usuarios', JSON.stringify(usuariosEnLS));

                        this.resenia = [...usuariosEnLS[usuarioId].resenias];

                        this.obtenerResenias();
                    })
                    .catch(error => {
                        console.error('Hubo un error al intentar eliminar la reseña:', error);
                        this.mostrarAlerta = true;
                        this.tipoAlerta = 'error';
                        this.mensajeAlerta = 'Ocurrió un error al intentar eliminar tu reseña.';
                    })
                }
            }
            this.$refs.modalComponent.cerrarModal();
            this.$emit('update:reseniaSeleccionada', null);
        },
        formatearFecha: function(fecha){
            const fechaFormateada = new Date(fecha);
            const options = { day: '2-digit', month: '2-digit', year: 'numeric', hour: '2-digit', minute: '2-digit'};
            return fechaFormateada.toLocaleDateString('es-ES', options);
        }
    },
    mounted:function(){
        this.obtenerResenias();
        this.usuarioActual = this.getUsuarioIdFromLS();
    },
    watch: {
        id: function(){
            this.obtenerResenias();
        },
        resenia: function(){
            this.verificarResenias();
        }
    }
}
</script>

<style scoped>
  span{
    color: red;
    font-size: .8rem;
    margin-right: 2rem;
    display: flex;
    align-items: center;
  }

  #usDeslogueado{
    color: black;
    font-size: 1rem;
    margin-top: 2rem;
    margin-bottom: 2rem;
  }

  #usDeslogueado a{margin-left: .25rem;}

  #usDeslogueado a:first-of-type{margin-right: .25rem;}

  #alert{top: 100px;}

  svg{
    width: 18px;
    height: 18px;
  }
  .comentarios{
    align-items: center;
    padding: .5rem;
    margin-bottom: .5rem;
  }

  #sinresenia{
    margin-top: 1rem;
    margin-bottom: 2rem;
  }

 form{
    margin-top: 1rem;
    margin-bottom: 2rem;
  }

  aside:first-of-type{margin-top: 2rem;}

  aside h3{margin-top: 1.5rem;}
  .red{
    color: red;
    background-color: white !important;
  }
  .green{
    color: green;
    background-color: white !important;
  }
  .fechaResenia{
    color: gray;
    font-size: .8rem;
  }
</style>

