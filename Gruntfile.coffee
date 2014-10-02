module.exports = (grunt)->

  coffeeify = require "coffeeify"
  stringify = require "stringify"

  grunt.initConfig
    connect:
      server:
        options:
          port: 3000
          base: [".", "bin/"]

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

    less:    
      dev:
        files:
          "bin/css/main.css": ["src/css/main.less"]


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
      title:
        options:
          data: (dest, src)->
            src = src[0]
            view = (src.match /\/\w+\.jade$/g)[0].replace /(\/)|(\.jade)/g, ""
            require "./src/mocks/#{view}.json"
        files: 
          "bin/index.html": "src/views/index.jade"
          "bin/list.html": "src/views/list.jade"

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

  grunt.registerTask "default", ->
    grunt.task.run [
      "connect"
      "clean:bin"
      "browserify"
      "less"
      "jade"
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
