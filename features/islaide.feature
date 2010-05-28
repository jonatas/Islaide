Feature: Get alignment, type and size of elements by some snippets
  As a developer 
  I want to use snippets
  To get my presentation done  

  Scenario: Render Alignments
      Given the following "snippet" should render the following "alignment"
       | snippet | alignment |
       | >       | right   |
       | \|      | center |
  
  Scenario: Render Formatters
      Given the following "snippet" should render the following "formatter, html_tag"
       | snippet | formatter   | html_tag |
       | #       | title       |     h1   |
       | ##      | subtitle    |     h2   |
       | ###     | subsubtitle |     h3   |
       | *       | bullet      |     li   |
       | $       | code        |     pre  |


  Scenario: Render html
      Given the following "text" should render the following "parse"
       | text            |  parse               |
       | # title         | <h1>title</h1>       |
       | ## subtitle     | <h2>subtitle</h2>    |
       | ### subsubtitle | <h3>subsubtitle</h3> |
       | ###> subright   | <h3 class='right'>subright</h3> |
       | \| center        | <p class='center'>center</p> |
