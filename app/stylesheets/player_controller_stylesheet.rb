class PlayerControllerStylesheet < ApplicationStylesheet
  # Add your view stylesheets here. You can then override styles if needed, example:
  # include FooStylesheet

  def setup
    # Add stylesheet specific setup stuff here.
    # Add application specific setup stuff in application_stylesheet.rb
  end

  def root_view(st)
    st.background_color = color.white
  end

  def play_stop(st)
  end

  def thumbnail(st)

  end

  def podcast_title(st)

  end

  def episode_title(st)

  end

  def playback_view(st)

  end

  def start_time(st)

  end

  def end_time(st)

  end

  def slider(st)

  end
end
