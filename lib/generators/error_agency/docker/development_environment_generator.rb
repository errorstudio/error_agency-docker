module ErrorAgency
  module Docker
    class DevelopmentEnvironmentGenerator < Rails::Generators::Base

      desc "Install files for running Rails in docker containers, in development."

      source_root File.expand_path("../templates", __FILE__)

      class_option :build, type: :boolean, desc: "Build the docker images after running the generator", default: false
      class_option :mysql, type: :boolean, desc: "Generate docker configs for MySQL. Installs by default.", default: true
      class_option :redis, type: :boolean, desc: "Generate docker configs for Redis. Installs by default.", default: true
      class_option :mailhog, type: :boolean, desc: "Generate docker configs for Mailhog. Installed by default.", default: true
      class_option :elasticsearch, type: :boolean, desc: "Generate docker configs for Elasticsearch. NOT installed by default.", default: false
      class_option :headless_chrome, type: :boolean, desc: "Generate configs for headless Chrome. NOT installed by default.", default: false
      class_option :ruby_version, type: :string, desc: "Define the Ruby version to use", default: "2.6.5"
      class_option :elasticsearch_version, type: :string, desc: "Define the Elasticsearch version to use", default: "6.2.4"
      class_option :mysql_version, type: :string, desc: "Define the MySQL version to use", default: "5.6"


      def create_docker_compose
        @mysql = options[:mysql]
        @redis = options[:redis]
        @elasticsearch = options[:elasticsearch]
        @mailhog = options[:mailhog]
        @mysql_version = options[:mysql_version]

        template "docker_compose.yml.erb", "docker-compose.yml"
      end

      def create_rails_base
        @ruby_version = options[:ruby_version]

        template "rails_base/Dockerfile.erb", "config/docker/rails_base/Dockerfile"
        template "rails_base/entrypoint.sh.erb", "config/docker/rails_base/entrypoint.sh"
        system 'chmod 755 config/docker/rails_base/entrypoint.sh'
      end

      def create_elasticsearch
        if options[:elasticsearch]
          @elasticsearch_version = options[:elasticsearch_version]
          template "elasticsearch/Dockerfile.erb", "config/docker/elasticsearch/Dockerfile"
        end
      end

      def write_configs

      end

      def build_images
        if options[:build]
          system "docker-compose build && docker-compose run --rm shell bundle"

        end
      end


    end
  end
end
