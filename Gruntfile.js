module.exports = function(grunt) {

  // Add the grunt-mocha-test tasks.
  grunt.loadNpmTasks('grunt-mocha-test');

  grunt.initConfig({
    // Configure a mochaTest task
    mochaTest: {
      test: {
        options: {
          ui: 'bdd',
          reporter: 'spec',
          // coffeescript compiler
          require: 'coffee-script/register'
        },
        src: './specs/**/*.coffee',
        dest: './target/report.html'
      }
    }
  });

  grunt.registerTask('default', 'mochaTest');
  grunt.registerTask('run:specs', 'mochaTest');
};