import Vue from 'vue';
import Vuetify from 'vuetify/lib/framework';

Vue.use(Vuetify);

export default new Vuetify({
    theme:{ 
        themes:{
         light:{
          /*primary: '#e30b33',
          secondary: '#17d909',*/

          primary: '#3f51b5',
          secondary: '#2196f3',
          accent: '#2196f3',
          error: '#f44336',
          warning: '#ffeb3b',
          info: '#009688',
          success: '#4caf50'
    
         },
        
      },
  }


});
