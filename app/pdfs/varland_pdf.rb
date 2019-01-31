require "prawn/measurement_extensions"

class VarlandPdf < Prawn::Document

  DEFAULT_MARGIN = 0
  DEFAULT_LAYOUT = :portrait

  def initialize
    super(top_margin: self.class::DEFAULT_MARGIN,
          bottom_margin: self.class::DEFAULT_MARGIN,
          left_margin: self.class::DEFAULT_MARGIN,
          right_margin: self.class::DEFAULT_MARGIN,
          page_layout: self.class::DEFAULT_LAYOUT)
    define_fonts
  end

  def define_fonts
    font_families.update(
      "Whitney" => {
        :normal       => Rails.root.join('lib', 'assets', 'Whitney-Book.ttf'),
        :italic       => Rails.root.join('lib', 'assets', 'Whitney-BookItalic.ttf'),
        :bold         => Rails.root.join('lib', 'assets', 'Whitney-Semibold.ttf'),
        :bold_italic  => Rails.root.join('lib', 'assets', 'Whitney-SemiboldItalic.ttf')
      }
    )
    font_families.update(
      "Whitney Bold" => {
        :normal       => Rails.root.join('lib', 'assets', 'Whitney-Bold.ttf'),
        :italic       => Rails.root.join('lib', 'assets', 'Whitney-BoldItalic.ttf'),
        :bold         => Rails.root.join('lib', 'assets', 'Whitney-Black.ttf'),
        :bold_italic  => Rails.root.join('lib', 'assets', 'Whitney-BlackItalic.ttf')
      }
    )
    font_families.update(
      "Menlo" => {
        :normal       => Rails.root.join('lib', 'assets', 'Menlo-Regular.ttf'),
        :italic       => Rails.root.join('lib', 'assets', 'Menlo-Italic.ttf'),
        :bold         => Rails.root.join('lib', 'assets', 'Menlo-Bold.ttf'),
        :bold_italic  => Rails.root.join('lib', 'assets', 'Menlo-BoldItalic.ttf')
      }
    )
    font_families.update(
      "Arial Narrow" => {
        :normal       => Rails.root.join('lib', 'assets', 'ARIALN.TTF'),
        :italic       => Rails.root.join('lib', 'assets', 'ARIALNI.TTF'),
        :bold         => Rails.root.join('lib', 'assets', 'ARIALNB.TTF'),
        :bold_italic  => Rails.root.join('lib', 'assets', 'ARIALNBI.TTF')
      }
    )
    font_families.update(
      "Arial" => {
        :normal       => Rails.root.join('lib', 'assets', 'arial.ttf'),
        :italic       => Rails.root.join('lib', 'assets', 'ariali.ttf'),
        :bold         => Rails.root.join('lib', 'assets', 'arialbd.ttf'),
        :bold_italic  => Rails.root.join('lib', 'assets', 'arialbi.ttf')
      }
    )
    font_families.update(
      "Source Code Pro" => {
        :normal       => Rails.root.join('lib', 'assets', 'SourceCodePro-Regular.ttf'),
        :italic       => Rails.root.join('lib', 'assets', 'SourceCodePro-It.ttf'),
        :bold         => Rails.root.join('lib', 'assets', 'SourceCodePro-Bold.ttf'),
        :bold_italic  => Rails.root.join('lib', 'assets', 'SourceCodePro-BoldIt.ttf')
      }
    )
    font_families.update(
      "Courier New" => {
        :normal       => Rails.root.join('lib', 'assets', 'Courier New.ttf'),
        :italic       => Rails.root.join('lib', 'assets', 'Courier New Italic.ttf'),
        :bold         => Rails.root.join('lib', 'assets', 'Courier New Bold.ttf'),
        :bold_italic  => Rails.root.join('lib', 'assets', 'Courier New Bold Italic.ttf')
      }
    )    
    font_families.update(
      "SF Mono" => {
        :normal       => Rails.root.join('lib', 'assets', 'SFMono-Medium.ttf'),
        :italic       => Rails.root.join('lib', 'assets', 'SFMono-Semibold.ttf'),
        :bold         => Rails.root.join('lib', 'assets', 'SFMono-Bold.ttf'),
        :bold_italic  => Rails.root.join('lib', 'assets', 'SFMono-Heavy.ttf')
      }
    )

  end

  # Draws horizontal line.
  def hline(x, y, length)
    stroke_line([x.in, y.in], [(x + length).in, y.in])
  end

  # Draws vertical line.
  def vline(x, y, length)
    stroke_line([x.in, y.in], [x.in, (y - length).in])
  end

  # Alias for vms_text_box.
  def txtb(text, x, y, width, height, size = 10, style = :normal, align = :center, valign = :center, font_family = nil, font_color = nil)
    return if text.blank?
    font_family = @standard_font if font_family.nil?
    font_color = @standard_color if font_color.nil?
    font(font_family,
          style: style)
    font_size(size)
    fill_color(font_color)
    text_box(text,
              at: [x.in, y.in],
              width: width.in,
              height: height.in,
              align: align,
              valign: valign,
              inline_format: true,
              overflow: :shrink_to_fit)
  end

  def inches_to_points(inches)
    return inches * 72.0
  end
  def _i(inches)
    return self.inches_to_points(inches)
  end

  def points_to_inches(points)
    return points / 72.0
  end
  def _p(points)
    return self.points_to_inches(points)
  end

# Protected methods.
protected

  # Reference Rails helpers.
  def helpers
    ApplicationController.helpers
  end

end