module.exports = (grunt)->

  coffeeify = require "coffeeify"
  stringify = require "stringify"

  grunt.initConfig
    connect:
      server:
        options:
          port: 3000
          base: [".", "bin/"]

    express: 
      server: 
        options:
          opts: ['node_modules/coffee-script/bin/coffee']
          script: './mock-server.coffee'

    clean: 
      bin: ["bin"]
      dist: ["dist"]

    copy:
      assets:
        src: "assets/**/*"
        dest: "dist/"

    browserify: 
      dev: 
        options:
          preBundleCB: (b)->
            b.transform(coffeeify)
            b.transform(stringify({extensions: [".hbs", ".html", ".tpl", ".txt"]}))
        expand: true
        flatten: true
        src: ["src/js/*.coffee"]
        dest: "bin/js"
        ext: ".js"
      test:
        options:
          preBundleCB: (b)->
            b.transform(coffeeify)
            b.transform(stringify({extensions: [".hbs", ".html", ".tpl", ".txt"]}))
        expand: true
        flatten: true
        src: ["test/test.coffee"]
        dest: "bin/test"
        ext: ".js"


    watch:
      compile:
        options:
          livereload: true
        files: [
          "src/**/*.coffee", 
          "src/**/*.less", 
          "src/**/*.html", 
          "index.html", 
          "test/**/*.coffee", 
          "test/**/*.html", 
          "src/**/*.jade",
          "src/**/*.json"
        ]
        tasks: ["browserify", "less", "jade", "mocha"]

      server: 
        options:
          livereload: true
          spawn: false
        files: [
          "mock-server.coffee"
        ]
        tasks: ["express:server"]

    less:    
      dev:
        files: [{
          expand: true
          cwd: "src/css/"
          src: ["*.less"]
          dest: "bin/css"
          ext: ".css"
        }]


    uglify:
      build:
        files: [{
          expand: true
          cwd: "bin/js/"
          src: ["**/*.js"]
          dest: "dist/js"
          ext: ".min.js"
        }]

    cssmin:    
      build:
        files:
          "dist/css/style.min.css": ["bin/css/main.css"]

    mocha:
        test:
            src: ["test/**/*.html"]
            options:
                run: true
                reporter: "Spec"

    jade:
      dev:
        options:
          data: (dest, src)->
            src = src[0]
            view = (src.match /\/[\w\-]+\.jade$/g)[0].replace /(\/)|(\.jade)/g, ""
            try
              data = require "./src/mocks/#{view}.coffee"
            catch e
              console.warn "./src/mocks/#{view}.coffee is not found, use {}. But no worries." 
              data = {}
            data
        files: [{
            expand: true
            cwd: "src/views/"
            src: ["*.jade"]
            dest: "bin/"
            ext: ".html"
        }]

  grunt.loadNpmTasks "grunt-contrib-connect"
  grunt.loadNpmTasks "grunt-contrib-clean"
  grunt.loadNpmTasks "grunt-browserify"
  grunt.loadNpmTasks "grunt-contrib-less"
  grunt.loadNpmTasks "grunt-contrib-watch"
  grunt.loadNpmTasks "grunt-contrib-uglify"
  grunt.loadNpmTasks "grunt-contrib-cssmin"
  grunt.loadNpmTasks "grunt-mocha"
  grunt.loadNpmTasks "grunt-contrib-copy"
  grunt.loadNpmTasks "grunt-contrib-jade"
  grunt.loadNpmTasks "grunt-express-server"

  grunt.registerTask "default", ->
    grunt.task.run [
      'express:server'
      "clean:bin"
      "browserify"
      "less"
      "mocha"
      "watch"
    ]

  grunt.registerTask "build", [
    "clean:bin"
    "clean:dist"
    "browserify" 
    "less" 
    "uglify"
    "cssmin"
    "copy"
  ]
