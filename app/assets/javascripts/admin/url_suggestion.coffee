class UrlSuggestion
  no_diacritics = {
    'á': 'a',
    'č': 'c',
    'ď': 'd',
    'ě': 'e',
    'é': 'e',
    'í': 'i',
    'ň': 'n',
    'ó': 'o',
    'ř': 'r',
    'š': 's',
    'ť': 't',
    'ů': 'u',
    'ú': 'u',
    'ý': 'y',
    'ž': 'z',
  }

  suggest: (input_string) ->
    input_string  = input_string.toLowerCase()
    result_string = ""

    for char, index in input_string.split ''
      result_string +=
        if typeof no_diacritics[char] == 'undefined'
          char
        else
          no_diacritics[char]

    result_string = result_string.replace(/[^a-z0-9_]+/g, '-').replace(/^-|-$/g, '');

jQuery ->
  url_suggestion = new UrlSuggestion

  $("input[type=text].suggest_url").bind('keyup', ->
    $("input[type=url]").val(url_suggestion.suggest($(this).val()))
  )
