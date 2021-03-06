# DocPad Configuration File
# http://docpad.org/docs/config

# Define the DocPad Configuration
docpadConfig = {
    # Out Path
    # Where should we put our generated website files?
    # If it is a relative path, it will have the resolved `rootPath` prepended to it
    outPath: 'published'  # default

    # Src Path
    # Where can we find our source website files?
    # If it is a relative path, it will have the resolved `rootPath` prepended to it
    srcPath: 'src'  # default

    # Documents Paths
    # An array of paths which contents will be treated as documents
    # If it is a relative path, it will have the resolved `srcPath` prepended to it
    documentsPaths: [  # default
        'docs'
    ]

    # Files Paths
    # An array of paths which contents will be treated as files
    # If it is a relative path, it will have the resolved `srcPath` prepended to it
    filesPaths: [  # default
        'files'
        'public'
    ]

    # Layouts Paths
    # An array of paths which contents will be treated as layouts
    # If it is a relative path, it will have the resolved `srcPath` prepended to it
    layoutsPaths: [  # default
        'layouts'
    ]

    # Render Passes
    # How many times should we render documents that reference other documents?
    renderPasses: 1  # default

    # Check Version
    # Whether or not to check for newer versions of DocPad
    checkVersion: true # default

    # =================================
    # Template Configuration

    # Template Data
    # Use to define your own template data and helpers that will be accessible to your templates
    # Complete listing of default values can be found here: http://docpad.org/docs/template-data
    templateData:
        # Specify some site properties
        version: "2.0.0" #update me on new release
        springVersion: "2.0.0"
        reldate: "31 August 2013"
        secnote: '<div class="metro danger label">Security Notice</div>'
        shout: '<div class="metro warning large btn">NOTE</div>'
        new2: "<div class='metro label primary'>New in 2.0</div>"
        FIXME: "<div class='metro large btn warning'>@FIXME</div>"
        site:
            scripts: [
                      "//ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"
                      "//cdnjs.cloudflare.com/ajax/libs/modernizr/2.6.2/modernizr.min.js",
                      "js/libs/gumby.js"
                      "js/libs/ui/gumby.fittext.js"
                      "js/libs/ui/gumby.fixed.js"
                      "js/libs/ui/gumby.navbar.js"
                      "js/libs/ui/gumby.retina.js"
                      "js/libs/ui/gumby.skiplink.js"
                      "js/libs/ui/gumby.tabs.js"
                      "js/libs/ui/gumby.toggleswitch.js"
                      "js/libs/gumby.init.js"
                      "js/plugins.js"
                      "js/main.js"
                      ]
            styles: [
                      "//fonts.googleapis.com/css?family=Open+Sans:400italic,400,300,600,700"
                      "css/gumby.css"
                     ]
            # The production url of our website
            url: "http://docs.stardog.com/"

            # The default title of our website
            title: "Stardog Documentation"

            # The website description (for SEO)
            description: """ """

            # The website keywords (for SEO) separated by commas
            keywords: """ """

        # -----------------------------
        # Helper Functions

        # Get the prepared site/document title
        # Often we would like to specify particular formatting to our page's title
        # we can apply that formatting here
        getPreparedTitle: ->
            # if we have a document title, then we should use that and suffix the site's title onto it
            if @document.title
                "Stardog #{@version} Docs: #{@document.title}"
            # if our document does not have it's own title, then we should just use the site's title
            else
                @site.title

        # Get the prepared site/document description
        getPreparedDescription: ->
            # if we have a document description, then we should use that, otherwise use the site's description
            @document.description or @site.description

        # Get the prepared site/document keywords
        getPreparedKeywords: ->
            # Merge the document keywords with the site keywords
            @document.keywords or @site.keywords

    # =================================
    # Plugin Configuration

    # Skip Unsupported Plugins
    # Set to `false` to load all plugins whether or not they are compatible with our DocPad version or not
    skipUnsupportedPlugins: false  # default

    # Enable Unlisted Plugins
    # Set to false to only enable plugins that have been explicity set to `true` inside `enabledPlugins`
    enabledUnlistedPlugins: true  # default

    # Enabled Plugins
    enabledPlugins:  # example
        footnotesbak: false
        highlightjs: false
        # Unless, enableUnlistedPlugins is set to false, all plugins are enabled by default
        frontmatter: false
        tableofcontents: false
        nodesass: false
        stardogtoc: false

    # Configure Plugins
    # Should contain the plugin short names on the left, and the configuration to pass the plugin on the right
    plugins:  # example
        footnotes:
            test: true
        markedOptions:
            gfm: true
            tables: true
            sanitize: false
            smartypants: true
        tableofcontents:
            requiredMetadataField: "toc"
            headerIdPrefix: "sd-"
            headerSelectors: "h2"
        watchOptions: preferredMethods: ['watchFile','watch']
        sass:
            sassPath: 'E:\Ruby200-x64\bin\sass.bat'
            scssPath: 'E:\Ruby200-x64\bin\scss.bat'
            compass: 'E:\Ruby200-x64\bin\compass.bat'
        footnotes:
          chapters: [
            title: "Using Stardog"
            subtitle: "Covers basic installation and starting a Stardog Server in <em>five easy steps</em>."
            sections: ["using", "console"]
          ,
            title: "Administering Stardog"
            subtitle: "Administering Stardog Server, databases, including configuration and deployment information."
            sections: ["admin", "security"]
          ,
            title: "Programming Stardog"
            subtitle: "Everything from reasoning, data validation, and SPARQL to programming Stardog with Java, JavaScript, and many other languages. Includes the documentation for Stardog Web."
            sections: [
              'java', 'web', 'icv', 'owl2', 'http', 'spring', 'groovy'
              ,
                title: 'Programming with Javascript'
                text:"The documentation for <a href=\"http://clarkparsia.github.io/stardog.js\">stardog.js</a>, which is available on <a href=\"https://github.com/clarkparsia/stardog.js\">Github</a> and <a href=\"http://docs.stardog.com/\">npm</a>."
            ]
          ,
            title: "Understanding Stardog"
            subtitle: "Background information on tuning, terminology, known issues, compatibility policies, etc."
            sections: [
              'manpages', 'performance', 'faq'
              ,
                title: "Stardog Compatibility Policies"
                text: "A statement of the policies we will pursue in evolving Stardog beyond the 1.0 release."
              ,
                title: "Known Issues"
                text: "Click here first before reporting an issue or bug."
              ,
                title: "Terminology"
                text: "A glossary of technical terms used in these docs."
            ]
          ]

    # =================================
    # Event Configuration

    # Events
    # Allows us to bind listeners to the events that DocPad emits
    # Complete event listing can be found here: http://docpad.org/docs/events
    events:  # example

        # Server Extend
        # Used to add our own custom routes to the server before the docpad routes are added
        serverExtend: (opts) ->
            # Extract the server from the options
            {server} = opts
            docpad = @docpad


    # =================================
    # Environment Configuration

    # Locale Code
    # The code we shall use for our locale (e.g. `en`, `fr`, etc)
    # If not set, we will attempt to detect the system's locale, if the locale can't be detected or if our locale file is not found for it, we will revert to `en`
    localeCode: null  # default

    # Environment
    # Which environment we should load up
    # If not set, we will default the `NODE_ENV` environment variable, if that isn't set, we will default to `development`
    env: null  # default

    # Environments
    # Allows us to set custom configuration for specific environments
    environments:  # default
        development:  # default
            # Always refresh from server
            maxAge: false  # default

            # Only do these if we are running standalone via the `docpad` executable
            checkVersion: process.argv.length >= 2 and /docpad$/.test(process.argv[1])  # default
            welcome: process.argv.length >= 2 and /docpad$/.test(process.argv[1])  # default
            prompts: process.argv.length >= 2 and /docpad$/.test(process.argv[1])  # default

            # Listen to port 9005 on the development environment
            port: 80  # example
}

# Export the DocPad Configuration
module.exports = docpadConfig
