# Export Plugin
module.exports = (BasePlugin) ->
  # Define chapters


  # Define Plugin
  class StardogtocPlugin extends BasePlugin
    # Plugin name
    name: 'stardogtoc'

    tocHtml: ''

    config:
      regex: /<toc:stardog\/?>/g
      subsectionSelector: '#mdblock h2'
      addHeaderIds: true
      headerIdPrefix: 'sd-'
      chapters: [
        title: "Using Stardog"
        subtitle: "Covers basic installation and starting a Stardog Server in <em>five easy steps</em>."
        sections: [
          title: "The Basics: Query, Write, Search"
          page: "using"
        ,
          title: "Stardog (Web) Console"
          page: "console"
        ]
      ,
        title: "Administering Stardog"
        subtitle: "Administering Stardog Server, databases, including configuration and deployment information."
        sections: [
          title: "Administration"
          page: "admin"
        ,
          title: "Security"
          page: "security"
        ]
      ,
        title: "Programming Stardog"
        subtitle: "Everything from reasoning, data validation, and SPARQL to programming Stardog with Java, JavaScript, and many other languages. Includes the documentation for Stardog Web."
        sections: [
          title: "Programming with Java"
          page: "java"
        ,
          title: "Building Stardog Web Apps"
          page: "web"
        ,
          title: "Integrity Constraint Validation"
          page: "icv"
        ,
          title: "OWL 2 Reasoning"
          page: "owl2"
        ,
          title: "HTTP Programming"
          page: "http"
        ,
          title: "Programming with Spring"
          page: "spring"
        ,
          title: "Programming with Groovy"
          page: "groovy"
        ,
          title: "Programming with Javascript"
          page: false
          text: "The documentation for <a href=\"http://clarkparsia.github.io/stardog.js\">stardog.js</a>, which is available on <a href=\"https://github.com/clarkparsia/stardog.js\">Github</a> and <a href=\"http://docs.stardog.com/\">npm</a>."
        ]
      ,
        title: "Understanding Stardog"
        subtitle: "Background information on tuning, terminology, known issues, compatibility policies, etc."
        sections: [
          title: "The Man Pages"
          page: "manpages"
        ,
          title: "Stardog Performance: Benchmarks, Tuning, Tips"
          page: "performance"
        ,
          title: "Frequently Asked Questions"
          page: "faq"
        ,
          title: "Stardog Compatibility Policies"
          page: false
          text: "A statement of the policies we will pursue in evolving Stardog beyond the 1.0 release."
        ,
          title: "Known Issues"
          page: false
          text: "Click here first before reporting an issue or bug."
        ,
          title: "Terminology"
          page: false
          text: "A glossary of technical terms used in these docs."
        ]
      ]

    buildPages: () ->
      if @built then return

      @pages = {}

      for chapter in @config.chapters
        for section in chapter.sections
          if !section.page || @pages[section.page]? then continue

          @pages[section.page] = section
          section.built = false

    buildPage: (file) ->
      name = file.attributes.basename

      page = @pages[name]

      if !page || page.built || file.attributes.outExtension isnt 'html' then return

      console.log 'buildPage', name

      page.built = true

      page.url = file.attributes.url
      page.subsections = []

      cheerio = require 'cheerio'
      $ = cheerio.load(file.attributes.contentRendered)

      #console.log('sub', @config.subsectionTag, $(@config.subsectionTag), file.attributes)

      tag = @config.subsectionSelector
      config = @config
      changed = false

      $(tag).each (index, elem) ->
        $th = $(this)
        title = $th.text()
        id = $th.attr('id')

        if !id and config.addHeaderIds
          $th.attr('id', config.headerIdPrefix + title.replace(/[^a-zA-Z0-9]/g, '-').replace(/^-/, '').replace(/-+/, '-'))
          changed = true

        id = $th.attr('id')

        #console.log 'sub', title, id

        obj = {title:title, id:id, url:page.url}
        if id then obj.url += '#' + id
        page.subsections.push(obj)

      if changed then file.attributes.contentRendered = $.html()

    buildTocHtml: () ->
      @built = true
      @tocHtml = ''

      html = ''

      for chapter in @config.chapters
        ch = ''
        ch += "<h2>#{chapter.title}</h2>"
        ch += "<p>#{chapter.subtitle}</p>"

        for section in chapter.sections
          ch += "<h3><a href=\"#{section.url}\">#{section.title}</a></h3>"

          text = if section.text then section.text else ''

          ch += "<p>#{text}</p>"

          #console.log 'sec', section

          if section.subsections && section.subsections.length
            ch += "<ol class=\"chapter-toc\">"

            for subsection in section.subsections
              ch += "<li><a href=\"#{subsection.url}\">#{subsection.title}</a></li>"

            ch += "</ol><p></p>"

        html += ch

      @tocHtml = html

    renderBefore: (opts) ->
      # Prepare
      @buildPages()

    render: (opts) ->
      {inExtension, outExtension, templateData, file, content} = opts

      #if file.attributes.filename is 'admin.html.md' then console.log inExtension, outExtension, templateData

    renderDocument: (opts) ->
      file = opts.file

      if file.type isnt 'document' || opts.extension isnt 'html' || file.attributes.sdTocProcessed then return

      file.attributes.sdTocProcessed = true

      name = file.attributes.basename
      if !@pages[name] || !@config.addHeaderIds then return

      #console.log 'render', file.attributes

      # Add Header ids.



    writeBefore: (opts) ->
      documents = @docpad.getCollection 'documents'
      needsToc = []

      for model in documents.models
        @buildPage(model)

        if @config.regex.test(model.attributes.contentRendered) then needsToc.push(model)

      @buildTocHtml()

      for model in needsToc
        model.attributes.contentRendered = model.attributes.contentRendered.replace(@config.regex, @tocHtml)