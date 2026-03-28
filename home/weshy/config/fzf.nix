{ ... }:

{
  programs.fzf = {
    settings = {
        display = {
          layout = "reverse";
          height = 0.5;
          width = 0.5;
          border = "rounded";
          preview = "right:50%:hidden";
        }
    };
  };
}
