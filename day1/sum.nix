let
  sum = list:
    if (builtins.length list) >= 1 then
      (builtins.head list) + (sum (builtins.tail list))
    else
      0;
in
  sum