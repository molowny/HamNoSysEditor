module.exports = (grunt) ->

  grunt.initConfig

    coffee:
      options:
        bare: true

      src:
        expand: true
        cwd: 'src'
        src: ['**/*.coffee']
        dest: 'js'
        ext: '.js'

    less:
      all:
        options:
          paths: ['less']
        files:
          'dist/hamnosyseditor.css': ['less/hamnosyseditor.less']

    connect:
      server:
        options:
          port: 3000
          livereload: true
          middleware: (connect, options, middlewares) ->
            middlewares = middlewares or []
            middlewares.concat [
              require('connect-livereload')() # livereload middleware
              connect.static(options.base) # serve static files
              connect.directory(options.base) # make empty directories browsable
            ]

          open: 'http://localhost:3000/examples'

    watch:
      coffee:
        files: ['<%= coffee.src.cwd %>/**/*.coffee']
        tasks: ['coffee']
      less:
        files: ['less/hamnosyseditor.less']
        tasks: ['less']

  # Load all the plugins
  require('load-grunt-tasks')(grunt)

  grunt.registerTask 'default', ['connect', 'watch']
