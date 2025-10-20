let
  taken = n: list:
    builtins.trace "n: ${builtins.toString n}, list: ${builtins.toJSON list}"
    (if (builtins.length list) > 0 && n > 0 then 
      [(builtins.head list)] ++ (taken (n - 1) (builtins.tail list))
    else
      [ ]
      );

in
  taken