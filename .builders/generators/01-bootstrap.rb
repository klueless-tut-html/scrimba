KManager.action :bootstrap do
  def on_action
    application_name = :scrimba

    director = KDirector::Dsls::BasicDsl
      .init(k_builder,
        on_exist:                   :skip,                      # %i[skip write compare]
        on_action:                  :queue                      # %i[queue execute]
      )
      .data(
        application:                application_name,
        application_description:    'HTML Design System Tutorial - Learn how to create your own design system while building a Space Travel Website with CSS guru Kevin Powell',
        author:                     'David Cruwys',
        author_email:               'david@ideasmen.com.au',
        main_story:                 'As a Developer, I want know how to createa design system, so that I can have consistent style webapplications',
        copyright_date:             '2022'
      )
      .github(
        active: false,
        repo_name: application_name,
        organization: 'klueless-tut-html'
      ) do
        create_repository
        # delete_repository
        # list_repositories
        open_repository
        # run_command('git init')
      end
      .blueprint(
        active: false,
        name: :bin_hook,
        description: 'initialize repository',
        on_exist: :write) do

        cd(:app)

        run_command('git init')
        add('.gitignore')

        run_template_script('.git-setup.sh', dom: dom)

        run_command("git add .; git commit -m 'chore: #{self.options.description.downcase}'; git push")
        run_command("gh repo edit -d \"#{dom[:application_description]}\"")
      end
      .package_json(
        active: false,
        name: :package_json,
        description: 'Set up the package.json file for semantic versioning'
      ) do
        self
          .add('package.json', dom: dom)
          .play_actions

        # self
        #   .add_script('xxx', 'xxx')
        #   .sort
        #   .development
        #   .npm_add_group('xxx')

        # run_command("git add .; git commit -m 'chore: #{self.options.description.downcase}'; git push")
      end
      .blueprint(
        active: true,
        template_base_folder: 'html/design-system',
        name: :opinionated,
        description: 'opinionated files for a HTML design system',
        on_exist: :write) do

        cd(:app)

        debug

        add('index.css', dom: dom)
        add('index.html', dom: dom)
        add('index.pack.js', dom: dom)
        add('readme.md', dom: dom)

        # run_command("git add .; git commit -m 'chore: #{self.options.description.downcase}'; git push")
      end

    director.play_actions
  end
end

KManager.opts.app_name                    = 'scrimba'
KManager.opts.sleep                       = 2
KManager.opts.reboot_on_kill              = 0
KManager.opts.reboot_sleep                = 4
KManager.opts.exception_style             = :short
KManager.opts.show.time_taken             = true
KManager.opts.show.finished               = true
KManager.opts.show.finished_message       = 'FINISHED :)'
