Feature: Get alignment and markdown on snippets
  As a developer 
  I want to use snippets
  To get my presentation done  
  
  Scenario: Render html with markdown style and alignments
      Given the following "text" should render the following "parse"
       | text              |  parse                             |
       | # title           | <h1 id='title'>title</h1>          |
       | ## subtitle       | <h2 id='subtitle'>subtitle</h2>    |
       | ### mini hello    | <h3 id='mini_hello'>mini hello</h3> |
       | ###> sub on right | <h3 id='_sub_on_right' class='right'>sub on right</h3>  |
       | \| center         | <p class='center'>center</p>                            |
       | ##\| sub centered | <h2 id='_sub_centered' class='center'>sub centered</h2> |
       | * bullet          | <li>bullet</li>                                         |
       | - other bullet    | <li>other bullet</li>                                   |
       | $ puts 'hello'    | <pre class='code'>puts &#8216;hello&#8217;</pre>        |
