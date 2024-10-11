{ pkgs, config, ... }:

{
  environment = {

    sessionVariables = {
      OPENAI_API_KEY = "API key frome platform.openai.com";
    };

  };
}
