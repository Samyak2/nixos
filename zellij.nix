{...}: {
  programs.zellij = {
    enable = true;

    settings = {
      simplified_ui = true;
      pane_frames = false;
      scroll_buffer_size = 100000;
      copy_on_select = false;

      session_serialization = true;
      pane_viewport_serialization = true;
      scrollback_lines_to_serialize = 1000;
    };
  };
}
