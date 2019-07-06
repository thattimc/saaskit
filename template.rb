gem "saaskit"

after_bundle do
  run "spring stop"
  generate "saaskit:install"
end
