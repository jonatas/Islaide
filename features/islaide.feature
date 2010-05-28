Feature: Get alignment and markdown on snippets
  As a developer 
  I want to use snippets
  To get my presentation done  
  
  Scenario: Render html with alignments
      Given the following "text" should render the following "parse"
       | text            |  parse               |
       | # title         | <h1>title</h1>       |
       | ## subtitle     | <h2>subtitle</h2>    |
       | ### subsubtitle | <h3>subsubtitle</h3> |
       | ###> sub on right | <h3 class='right'>sub on right</h3> |
       | \| center         | <p class='center'>center</p> |
       | ##\| sub centered | <h2 class='center'>sub centered</h2> |
