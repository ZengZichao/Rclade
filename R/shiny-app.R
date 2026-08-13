# Copyright (c) 2026 Zeng Zichao
# Licensed under the MIT License (see LICENSE file)

# Shiny interface (Suggests: shiny)
#
#' Launch Rclade Shiny app
#'
#' Provides an interactive web interface for Rclade. Requires the shiny package.
#'
#' @section Concurrency:
#' The logger, step-progress, and interrupt subsystems use package-level global
#' environments (\code{.logger_env}, \code{.interrupt_env}).  Within a single R
#' process, multiple concurrent Shiny sessions will share (and may corrupt) this
#' state — log messages, step counters, and interrupt flags can cross between
#' sessions.  For production multi-user deployment, run one Shiny instance per R
#' process (e.g., behind a load balancer), or assign a dedicated log file per
#' task via \code{--log_file}.  A session-scoped state refactor is on the
#' roadmap.
#'
#' @export
run_rclade_shiny <- function() {
  if (!requireNamespace("shiny", quietly = TRUE)) {
    stop("Shiny interface requires the shiny package: install.packages('shiny')",
         call. = FALSE)
  }

  rclade_logo()

  ui <- shiny::fluidPage(
    # -- Custom CSS ----------------------------------------------
    # NOTE: no remote font loading (@import from CDNs) - the Inter family is
    # used only when installed locally and falls back to system fonts,
    # keeping the app fully functional offline / on HPC networks.
    shiny::tags$head(shiny::tags$style(shiny::HTML("
      * { font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif; }

      body {
        background: #F8F9FA;
        color: #2C2C2C;
      }

      /* -- Header -- */
      .app-header {
        background: #FFFFFF;
        border-bottom: 1px solid #E8ECEF;
        padding: 32px 28px 24px 28px;
        margin: -20px -15px 20px -15px;
      }
      .app-header h2 {
        font-weight: 400; font-size: 17px; color: #1A1A1A;
        margin: 0; letter-spacing: -0.2px;
      }
      .app-header h2 b {
        font-weight: 600;
      }

      /* -- Sidebar -- */
      .well {
        background: #FFFFFF;
        border: 1px solid #E8ECEF;
        border-radius: 8px;
        box-shadow: 0 1px 3px rgba(0,0,0,0.04);
        padding: 16px;
        min-height: calc(100vh - 100px);
      }

      /* -- Tabs -- */
      .nav-tabs {
        border-bottom: 1px solid #E8ECEF;
        margin-bottom: 12px;
        display: flex; flex-wrap: nowrap;
      }
      .nav-tabs > li {
        flex-shrink: 1; min-width: 0;
      }
      .nav-tabs > li > a {
        font-size: 11.5px; font-weight: 500; color: #8E8E93;
        padding: 6px 10px; border: none; border-radius: 4px 4px 0 0;
        letter-spacing: 0.2px; white-space: nowrap;
      }
      .nav-tabs > li.active > a,
      .nav-tabs > li.active > a:hover,
      .nav-tabs > li.active > a:focus {
        color: #1A1A1A; background: transparent;
        border: none; border-bottom: 2px solid #3B82F6;
      }
      .nav-tabs > li > a:hover {
        color: #3B82F6; background: transparent; border: none;
      }

      /* -- Form controls -- */
      .form-control, .selectize-input {
        border: 1px solid #E0E0E0; border-radius: 6px;
        font-size: 13px; color: #2C2C2C;
        box-shadow: none; transition: border-color 0.15s;
      }
      .form-control:focus, .selectize-input.focus {
        border-color: #3B82F6; box-shadow: 0 0 0 2px rgba(59,130,246,0.1);
      }
      .control-label {
        font-size: 12px; font-weight: 500; color: #6B7280;
        margin-bottom: 2px; letter-spacing: 0.1px;
      }

      /* -- File inputs -- */
      .input-group .form-control {
        border-radius: 6px 0 0 6px;
      }
      .input-group-btn .btn {
        border-radius: 0 6px 6px 0; border: 1px solid #E0E0E0;
        background: #F5F5F7; color: #6B7280; font-size: 12px;
        font-weight: 500;
      }

      /* -- Sliders -- */
      .irs--shiny .irs-bar {
        background: #3B82F6; border-color: #3B82F6;
      }
      .irs--shiny .irs-handle {
        background: #FFFFFF; border: 2px solid #3B82F6;
        box-shadow: 0 1px 3px rgba(0,0,0,0.1);
      }
      .irs--shiny .irs-from, .irs--shiny .irs-to, .irs--shiny .irs-single {
        background: #3B82F6; font-size: 11px;
      }

      /* -- Buttons -- */
      .btn-primary {
        background: #3B82F6; border: none; border-radius: 6px;
        font-weight: 500; font-size: 13px; letter-spacing: 0.2px;
        padding: 8px 16px; transition: all 0.15s;
      }
      .btn-primary:hover {
        background: #2563EB; box-shadow: 0 2px 6px rgba(59,130,246,0.3);
      }
      .btn-default {
        background: #F5F5F7; border: 1px solid #E0E0E0;
        border-radius: 6px; font-weight: 500; font-size: 12px;
        color: #6B7280; padding: 7px 16px;
      }
      .btn-default:hover {
        background: #EBEBED; color: #374151;
      }

      /* -- Checkboxes -- */
      .checkbox label {
        font-size: 12px; color: #4B5563;
      }

      /* -- Dividers -- */
      hr {
        border-color: #E8ECEF; margin: 12px 0;
      }

      /* -- Main panel -- */
      .main-panel-wrap {
        background: #FFFFFF;
        border: 1px solid #E8ECEF;
        border-radius: 8px;
        box-shadow: 0 1px 3px rgba(0,0,0,0.04);
        padding: 16px;
        min-height: calc(100vh - 100px);
      }
      #tree_plot {
        border-radius: 4px;
      }
      #summary {
        background: #F8F9FA;
        border: 1px solid #E8ECEF;
        border-radius: 6px;
        padding: 12px 16px;
        font-family: 'SF Mono', 'Fira Code', 'Menlo', monospace;
        font-size: 12px;
        color: #374151;
        max-height: 160px;
        overflow-y: auto;
        margin-top: 8px;
      }
      #summary pre {
        background: transparent; border: none;
        padding: 0; margin: 0; font-size: 12px;
        color: #374151;
      }

      /* -- Misc -- */
      .shiny-notification {
        border-radius: 8px; box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        font-size: 13px;
      }
      .shiny-output-error {
        color: #DC2626; font-size: 13px;
        padding: 12px; background: #FEF2F2;
        border-radius: 6px; border: 1px solid #FECACA;
      }
    "))),

    # -- Header --
    shiny::div(class = "app-header",
      shiny::h2(shiny::tags$b("Rclade"), ": Phylogenetic Tree Visualization")
    ),

    # -- Layout --
    shiny::sidebarLayout(
      shiny::sidebarPanel(width = 4,
        shiny::tabsetPanel(id = "tabs",
          shiny::tabPanel("Tree",
            shiny::br(),
            shiny::fileInput("tree_file", "Tree File",
              accept = c(".tre",".nwk",".newick",".nexus",".nex",".nhx")),
            shiny::fileInput("taxonomy_file", "External Taxonomy File",
              accept = c(".tsv",".csv",".txt")),
            shiny::hr(),
            shiny::selectInput("rank", "Collapse Rank",
              choices = c("none","domain","phylum","class","order","family","genus","species","subspecies"),
              selected = "phylum"),
            shiny::selectInput("triangle_mode", "Triangle Mode",
              choices = c("mixed","max","min","none"), selected = "mixed"),
            shiny::selectInput("space_mode", "Space Mode",
              choices = c("proportional","equal"), selected = "proportional"),
            shiny::textInput("clade", "Single Clade", placeholder = "e.g. Cyanobacteriota"),
            shiny::checkboxInput("strict", "Strict monophyly", FALSE)
          ),
          shiny::tabPanel("Layout",
            shiny::br(),
            shiny::selectInput("layout", "Layout",
              choices = c("rectangular","circular"), selected = "rectangular"),
            shiny::sliderInput("angle", "Fan Angle", 10, 360, 360, step = 10),
            shiny::numericInput("line_width", "Line Width", 1, min = 0.1, max = 5, step = 0.1),
            shiny::selectInput("tree_start_position", "Tree Position",
              choices = c("right","left"), selected = "right"),
            shiny::hr(),
            shiny::checkboxInput("show_tip_labels", "Show Tip Labels", FALSE),
            shiny::numericInput("tip_label_size", "Tip Label Size", 2, min = 0.5, max = 10, step = 0.5)
          ),
          shiny::tabPanel("Taxonomy",
            shiny::br(),
            shiny::selectInput("taxonomy_format", "Label Format",
              choices = c("auto","GTDB","Silva","NCBI","custom_rank","custom_regex"),
              selected = "auto"),
            shiny::selectInput("taxonomy_delimiter_mode", "Parse Strategy",
              choices = c("reverse","greedy","segment"), selected = "reverse"),
            shiny::textInput("taxonomy_table_sep", "Table Separator", ";"),
            shiny::textInput("taxonomy_levels", "Custom Levels",
              placeholder = "e.g. k:kingdom,ss:subspecies"),
            shiny::hr(),
            shiny::checkboxInput("taxonomy_file_header", "File has header", FALSE),
            shiny::selectInput("taxonomy_file_sep", "File Separator",
              choices = c("auto","tab","comma"), selected = "auto"),
            shiny::selectInput("taxonomy_source_priority", "Source Priority",
              choices = c("table","embedded"), selected = "table")
          ),
          shiny::tabPanel("Timescale",
            shiny::br(),
            shiny::checkboxInput("add_timescale", "Add Timescale", TRUE),
            shiny::selectInput("unit", "Time Unit",
              choices = c("auto","Ga","Ma"), selected = "auto"),
            shiny::selectInput("timescale_mode", "Timescale Mode",
              choices = c("radial","linear"), selected = "radial"),
            shiny::selectInput("timescale_position", "Position",
              choices = c("right","left","top","bottom"), selected = "right"),
            shiny::selectInput("timescale_levels", "Levels",
              choices = c("eons,eras","eons,eras,periods","eras","eons","periods"),
              selected = "eons,eras"),
            shiny::textInput("timescale_version", "ICS Version", "ICS 2023/02"),
            shiny::checkboxInput("geo_events", "Show geological events", FALSE)
          ),
          shiny::tabPanel("Colors",
            shiny::br(),
            shiny::selectInput("color_palette", "Palette",
              choices = c("viridis","Set1","Set2","Set3","Paired","Dark2","Accent","rainbow"),
              selected = "viridis"),
            shiny::textInput("color_mapping", "Manual Mapping",
              placeholder = "e.g. Proteobacteria=#E41A1C,Firmicutes=#377EB8"),
            shiny::textInput("color_rank", "Color by Rank", placeholder = "e.g. phylum"),
            shiny::hr(),
            shiny::selectInput("legend_position", "Legend Position",
              choices = c("bottom","right","left","top","none"), selected = "bottom"),
            shiny::numericInput("legend_nrow", "Legend Rows", value = NULL),
            shiny::numericInput("legend_ncol", "Legend Columns", value = NULL),
            shiny::textInput("legend_title", "Legend Title", placeholder = "auto")
          ),
          shiny::tabPanel("Annotations",
            shiny::br(),
            shiny::checkboxInput("show_clade_label", "Show Clade Labels", FALSE),
            shiny::checkboxInput("show_clade_count", "Show Species Count", TRUE),
            shiny::numericInput("clade_label_offset", "Clade Label Offset", 50, min = 0, max = 5000, step = 10),
            shiny::numericInput("clade_label_fontsize", "Clade Label Font Size", 3, min = 1, max = 20, step = 0.5),
            shiny::hr(),
            shiny::checkboxInput("show_support", "Show Node Support", FALSE),
            shiny::numericInput("support_threshold", "Support Threshold", 0.95, min = 0, max = 1, step = 0.01),
            shiny::checkboxInput("show_hpd", "Show HPD Bars", FALSE),
            shiny::textInput("hpd_color", "HPD Color", "firebrick"),
            shiny::hr(),
            shiny::textInput("highlight", "Highlight Clades", placeholder = "e.g. LUCA, LACA"),
            shiny::numericInput("highlight_alpha", "Highlight Alpha", 0.2, min = 0, max = 1, step = 0.05)
          ),
          shiny::tabPanel("Output",
            shiny::br(),
            shiny::textInput("main_title", "Main Title", placeholder = "optional"),
            shiny::textInput("sub_title", "Subtitle", placeholder = "optional"),
            shiny::hr(),
            shiny::numericInput("width", "Width (in)", 14, min = 4, max = 40, step = 1),
            shiny::numericInput("height", "Height (in)", 10, min = 3, max = 30, step = 1),
            shiny::hr(),
            shiny::checkboxInput("ignore_malformed", "Skip malformed inputs", FALSE),
            shiny::checkboxInput("ignore_branch_length", "Ignore branch lengths", FALSE),
            shiny::checkboxInput("low_memory", "Low memory mode", FALSE)
          )
        ),
        shiny::br(),
        shiny::actionButton("plot_btn", "Generate Plot", class = "btn-primary", width = "100%"),
        shiny::br(), shiny::br(),
        shiny::downloadButton("download_pdf", "Download PDF")
      ),

      shiny::mainPanel(width = 8,
        shiny::div(class = "main-panel-wrap",
          shiny::uiOutput("main_content")
        )
      )
    )
  )

  server <- function(input, output, session) {
    rv <- shiny::reactiveValues(p = NULL)

    shiny::observeEvent(input$plot_btn, {
      shiny::req(input$tree_file)

      opt_null <- function(x) if (is.null(x) || nchar(trimws(x)) == 0) NULL else trimws(x)

      tryCatch({
        tree_path <- input$tree_file$datapath
        tax_path <- if (!is.null(input$taxonomy_file)) input$taxonomy_file$datapath else NULL

        # T09 / E-T1: route raw UI strings -> structured params through the
        # single parse_plot_params() converter (shared with the CLI).
        parsed <- parse_plot_params(
          color_mapping     = input$color_mapping,
          taxonomy_levels   = input$taxonomy_levels,
          highlight         = input$highlight,
          taxonomy_file_sep = input$taxonomy_file_sep
        )
        # T09 / E-T1: resolve taxonomy source priority via the shared helper.
        tax_priority <- resolve_taxonomy_source_priority(
          no_taxonomy_file_priority = FALSE,
          taxonomy_source_priority = input$taxonomy_source_priority
        )

        rv$p <- plot_timetree(
          tree         = tree_path,
          rank         = input$rank,
          clade        = opt_null(input$clade),
          strict       = input$strict,
          triangle_mode = input$triangle_mode,
          space_mode   = input$space_mode,
          layout       = input$layout,
          angle        = input$angle,
          tree_start_position = input$tree_start_position,
          color_palette = input$color_palette,
          color_mapping = parsed$color_mapping,
          color_rank   = opt_null(input$color_rank),
          line_width   = input$line_width,
          show_tip_labels = input$show_tip_labels,
          tip_label_size = input$tip_label_size,
          add_timescale = input$add_timescale,
          timescale_levels = strsplit(input$timescale_levels, ",")[[1]],
          # "auto" maps to NULL = leave the tree's native units untouched
          # (aligned with the R API and CLI defaults; "Ga" converts x1000).
          unit         = if (identical(input$unit, "auto")) NULL else input$unit,
          timescale_mode = input$timescale_mode,
          timescale_position = input$timescale_position,
          timescale_version = input$timescale_version,
          geo_events   = input$geo_events,
          taxonomy_format = input$taxonomy_format,
          taxonomy_file = tax_path,
          taxonomy_file_sep = parsed$taxonomy_file_sep,
          taxonomy_file_header = input$taxonomy_file_header,
          taxonomy_source_priority = tax_priority,
          taxonomy_table_sep = input$taxonomy_table_sep,
          taxonomy_delimiter_mode = input$taxonomy_delimiter_mode,
          taxonomy_levels = parsed$taxonomy_levels,
          legend_position = input$legend_position,
          # L-E1: numericInputs can be NULL or NA; both must map to NULL.
          legend_nrow  = if (is.null(input$legend_nrow) || is.na(input$legend_nrow)) NULL else input$legend_nrow,
          legend_ncol  = if (is.null(input$legend_ncol) || is.na(input$legend_ncol)) NULL else input$legend_ncol,
          legend_title = opt_null(input$legend_title),
          show_clade_label = input$show_clade_label,
          show_clade_count = input$show_clade_count,
          clade_label_offset = input$clade_label_offset,
          clade_label_fontsize = input$clade_label_fontsize,
          show_support = input$show_support,
          support_threshold = input$support_threshold,
          show_hpd     = input$show_hpd,
          hpd_color    = input$hpd_color,
          main_title   = opt_null(input$main_title),
          sub_title    = opt_null(input$sub_title),
          highlight    = parsed$highlight,
          highlight_alpha = input$highlight_alpha,
          width        = input$width,
          height       = input$height,
          low_memory   = input$low_memory,
          ignore_malformed = input$ignore_malformed,
          ignore_branch_length = input$ignore_branch_length
        )
      }, error = function(e) {
        shiny::showNotification(paste("Error:", e$message), type = "error", duration = 10)
      })
    })

    output$main_content <- shiny::renderUI({
      if (is.null(rv$p)) {
        shiny::div(
          style = "display:flex;align-items:center;justify-content:center;height:560px;color:#B0B0B0;font-size:14px;",
          "Upload a tree file and click Generate Plot"
        )
      } else {
        shiny::tagList(
          shiny::plotOutput("tree_plot", height = "560px"),
          shiny::verbatimTextOutput("summary")
        )
      }
    })

    output$tree_plot <- shiny::renderPlot({ shiny::req(rv$p); rv$p })
    output$summary   <- shiny::renderPrint({ shiny::req(rv$p); summarize_timetree(rv$p) })
    output$download_pdf <- shiny::downloadHandler(
      filename = function() { paste0("rclade_plot_", Sys.Date(), ".pdf") },
      content  = function(file) { shiny::req(rv$p); save_timetree(rv$p, file) }
    )
  }

  shiny::shinyApp(ui, server)
}
