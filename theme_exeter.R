## Luke Pilling
## theme_exeter
## 4th August 2023

#' University of Exeter primary palette - https://brand.exeter.ac.uk/colour/
#'
#' @format character vector of hex code strings
#' @export
#'
#' @examples
#' exeter_theme_colors
#'
exeter_palette <- c(
  night_green     = '#022020',
  dark_green      = '#003C3C',
  deep_green      = '#007D69',
  rich_green      = '#00A87E',
  bright_green    = '#00C896',
  highlight_green = '#00DCA5'
)

#' University of Exeter ggplot theme colour palette
#'
#' @format character vector of hex code strings
#' @export
#'
#' @examples
#' exeter_theme_colors
#'
exeter_theme_colors <- c(
  background = exeter_palette[['dark_green']],
  text       = '#FFFFFF',
  panel      = '#FFFFFF',
  border     = exeter_palette[['deep_green']],
  lighter    = exeter_palette[['highlight_green']],
  light      = exeter_palette[['rich_green']],
  medium     = exeter_palette[['deep_green']],
  dark       = exeter_palette[['dark_green']]
)

#' University of Exeter ggplot theme colour palette - up to 9 discrete colours
#'
#' @format character vector of hex code strings
#' @export
#'
#' @examples
#' exeter_theme_colors_discrete
#'
exeter_theme_colors_discrete <- c(
  '#003C3C', '#007C69', '#00DCA5', 
  '#93272C', '#702182', '#250E63', '#798A5A', '#F4D64D','#9569BF','#E78599','#6AB3E7','#FFC62B','#E60000'
)

#' University of Exeter ggplot theme
#'
#' @param exeter_font should `theme_exeter` use Google Font's 'Outfit'? Default is `TRUE`.
#' @param ... additional parameters to pass to `ggplot2::theme()`
#'
#' @return a `ggplot2` `theme` element
#' @export
#'
#' @examples
#' library(ggplot2)
#'
#' ggplot(palmerpenguins::penguins, aes(x = flipper_length_mm, y = bill_length_mm)) +
#'   geom_point(color =  exeter_theme_colors["medium"]) +
#'   geom_smooth(method = 'lm',
#'               color = exeter_theme_colors["dark"],
#'               fill =  exeter_theme_colors["light"]) +
#'   labs(title = 'University of Exeter theme', 
#'        subtitle = "Antarctic penguins: flipper vs. bill length",
#'        caption = "Source: {palmerpenguins} R package",
#'        x = "Flipper length (mm)",
#'        y = "Bill length (mm)") +
#'   theme_exeter()
#'
#' ggplot(palmerpenguins::penguins, aes(x = flipper_length_mm, y = bill_length_mm)) +
#'   geom_point(aes(color = body_mass_g)) +
#'   geom_smooth(method = 'lm',
#'               color = exeter_theme_colors["dark"],
#'               fill =  exeter_theme_colors["light"]) +
#'   labs(title = 'Flipper vs. bill length', 
#'        subtitle = "Points colour-scaled by body mass",
#'        caption = "Source: {palmerpenguins} R package",
#'        x = "Flipper length (mm)",
#'        y = "Bill length (mm)",
#'        color = "Body mass (g)") +
#'   theme_exeter() +
#'   scale_color_exeter()
#'
#' ggplot(palmerpenguins::penguins, aes(flipper_length_mm)) +
#'   geom_density(aes(fill=factor(species)), alpha=0.8) +
#'   labs(title="Density plot of flipper length by species",
#'        subtitle = "Illustrating discrete scale",
#'        caption = "Source: {palmerpenguins} R package",
#'        x="Flipper length(mm)",
#'        fill="Species") +
#'   theme_exeter() +
#'   scale_fill_exeter_discrete()
#'
#' palmerpenguins::penguins |> na.omit() |>
#'   dplyr::mutate(body_mass_g_qt = as.factor(cut(body_mass_g, breaks=quantile(body_mass_g, probs=seq(0,1,0.1)), include=T, labels=F))) |>
#'   ggplot(aes(x=body_mass_g_qt, y=flipper_length_mm, fill=body_mass_g_qt)) +
#'     geom_boxplot() +
#'     labs(title="Box plot of flipper length by body mass",
#'          subtitle = "Further illustrating discrete scale",
#'          caption = "Source: {palmerpenguins} R package",
#'          x="Decile of body mass",
#'          y="Flipper length(mm)") +
#'     theme_exeter() +
#'     scale_fill_exeter_discrete() +
#'     theme(legend.position="none")
#'
theme_exeter <- function(exeter_font = TRUE, ...){
  
  # Add custom font from google fonts
  font_family = "Arial"
  if (exeter_font) {
    font_family = "Exeter"
    showtext::showtext_auto()
    sysfonts::font_add_google(name = "Outfit", family = font_family)
  }

  # CUSTOM THEME:
  ggplot2::theme(
    plot.background = element_rect(fill = exeter_theme_colors["background"]),
    panel.grid.minor = element_blank(),
    panel.grid.major = element_blank(),
    text = element_text(color = exeter_theme_colors["text"], family = font_family),
    title = element_text(size=20),
    panel.background = element_rect(fill = exeter_theme_colors["panel"]),
    panel.border = element_rect(fill = NA, color = exeter_theme_colors["border"],linewidth=1.2),
    axis.title = element_text(size=17),
    axis.text = element_text(size=13,color = exeter_theme_colors["text"]),
    axis.ticks = element_line(color = exeter_theme_colors["border"],linewidth=1),
    strip.background = element_rect(fill = exeter_theme_colors["background"], colour = exeter_theme_colors["border"]),
    strip.text = element_text(colour = exeter_theme_colors["text"]),
    legend.background = element_rect(fill = exeter_theme_colors["background"], color = NA),
    legend.box.background = element_blank(),
    legend.key = element_blank(),
    plot.title.position = 'plot', 
    plot.caption.position = 'plot',
    ...
  )
}

#' University of Exeter ggplot theme - colour scales
#'
#' @param ... Additional arguments to pass to `ggplot2::scale_[fill/color]_gradient()`
#'
#' @return a `ggplot` scale object
#'
#' @rdname scale_exeter
#' @export
#'
#' @examples
#' library(ggplot2)
#'
#' ggplot(mpg) +
#'   geom_point(aes(y = class, x = hwy, color = cyl)) +
#'   labs(title="MPG by Vehicle Type",
#'        caption="Source: mpg",
#'        x = "City Mileage",
#'        color ="# Cylinders") +
#'   theme_exeter() +
#'   scale_color_exeter()
#'
scale_fill_exeter <- function(...) {
  ggplot2::scale_fill_gradient(low = exeter_theme_colors["dark"], high = exeter_theme_colors["lighter"], ...)
}

#' @rdname scale_exeter
#' @export
scale_color_exeter <- function(...) {
  ggplot2::scale_color_gradient(low = exeter_theme_colors["dark"], high = exeter_theme_colors["lighter"], ...)
}

#' @rdname scale_exeter
#' @export
scale_fill_exeter_discrete <- function(...) {

  # repeat discrete colors up to n times for a given palette pal
  rot_pal <- function(pal) {
    pal <- unname(pal)
    function(n) {
      if (n <= length(pal)) {
        pal[seq_len(n)]
      } else {
        rep(pal, ceiling(n / length(pal)))[seq_len(n)]
      }
    }
  }

  # create discrete scale
  ggplot2::discrete_scale(aesthetics = 'fill', scale_name = exeter_theme_colors_discrete, ...,
                          palette = rot_pal(exeter_theme_colors_discrete))
}

#' @rdname scale_exeter
#' @export
scale_color_exeter_discrete <- function(...) {

  # repeat discrete colors up to n times for a given palette pal
  rot_pal <- function(pal) {
    pal <- unname(pal)
    function(n) {
      if (n <= length(pal)) {
        pal[seq_len(n)]
      } else {
        rep(pal, ceiling(n / length(pal)))[seq_len(n)]
      }
    }
  }

  # create discrete scale
  ggplot2::discrete_scale(aesthetics = 'color', scale_name = exeter_theme_colors_discrete,
                          palette = rot_pal(exeter_theme_colors_discrete), ...)
}

#' @rdname scale_exeter
#' @export
scale_colour_exeter <- scale_color_exeter

#' @rdname scale_exeter
#' @export
scale_colour_exeter_discrete <- scale_color_exeter_discrete

