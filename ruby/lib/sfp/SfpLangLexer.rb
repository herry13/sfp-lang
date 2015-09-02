#!/usr/bin/env ruby
#
# SfpLang.g
# --
# Generated using ANTLR version: 3.5
# Ruby runtime library version: 1.10.0
# Input grammar file: SfpLang.g
# Generated at: 2014-04-04 10:32:35
#

# ~~~> start load path setup
this_directory = File.expand_path( File.dirname( __FILE__ ) )
$LOAD_PATH.unshift( this_directory ) unless $LOAD_PATH.include?( this_directory )

antlr_load_failed = proc do
  load_path = $LOAD_PATH.map { |dir| '  - ' << dir }.join( $/ )
  raise LoadError, <<-END.strip!

Failed to load the ANTLR3 runtime library (version 1.10.0):

Ensure the library has been installed on your system and is available
on the load path. If rubygems is available on your system, this can
be done with the command:

  gem install antlr3

Current load path:
#{ load_path }

  END
end

defined?( ANTLR3 ) or begin

  # 1: try to load the ruby antlr3 runtime library from the system path
  require 'antlr3'

rescue LoadError

  # 2: try to load rubygems if it isn't already loaded
  defined?( Gem ) or begin
    require 'rubygems'
  rescue LoadError
    antlr_load_failed.call
  end

  # 3: try to activate the antlr3 gem
  begin
    defined?( gem ) and gem( 'antlr3', '~> 1.10.0' )
  rescue Gem::LoadError
    antlr_load_failed.call
  end

  require 'antlr3'

end
# <~~~ end load path setup

module SfpLang
  # TokenData defines all of the token type integer values
  # as constants, which will be included in all
  # ANTLR-generated recognizers.
  const_defined?( :TokenData ) or TokenData = ANTLR3::TokenScheme.new

  module TokenData

    # define the token constants
    define_tokens( :EOF => -1, :T__18 => 18, :T__19 => 19, :T__20 => 20, 
                   :T__21 => 21, :T__22 => 22, :T__23 => 23, :T__24 => 24, 
                   :T__25 => 25, :T__26 => 26, :T__27 => 27, :T__28 => 28, 
                   :T__29 => 29, :T__30 => 30, :T__31 => 31, :T__32 => 32, 
                   :T__33 => 33, :T__34 => 34, :T__35 => 35, :T__36 => 36, 
                   :T__37 => 37, :T__38 => 38, :T__39 => 39, :T__40 => 40, 
                   :T__41 => 41, :T__42 => 42, :T__43 => 43, :T__44 => 44, 
                   :T__45 => 45, :T__46 => 46, :T__47 => 47, :T__48 => 48, 
                   :T__49 => 49, :T__50 => 50, :T__51 => 51, :T__52 => 52, 
                   :T__53 => 53, :T__54 => 54, :T__55 => 55, :T__56 => 56, 
                   :T__57 => 57, :T__58 => 58, :T__59 => 59, :T__60 => 60, 
                   :T__61 => 61, :T__62 => 62, :T__63 => 63, :T__64 => 64, 
                   :T__65 => 65, :T__66 => 66, :T__67 => 67, :T__68 => 68, 
                   :T__69 => 69, :T__70 => 70, :T__71 => 71, :T__72 => 72, 
                   :T__73 => 73, :T__74 => 74, :T__75 => 75, :T__76 => 76, 
                   :T__77 => 77, :T__78 => 78, :T__79 => 79, :T__80 => 80, 
                   :T__81 => 81, :T__82 => 82, :T__83 => 83, :T__84 => 84, 
                   :T__85 => 85, :T__86 => 86, :BOOLEAN => 4, :COMMENT => 5, 
                   :ESC_SEQ => 6, :EXPONENT => 7, :HEX_DIGIT => 8, :ID => 9, 
                   :MULTILINE_STRING => 10, :NL => 11, :NULL => 12, :NUMBER => 13, 
                   :OCTAL_ESC => 14, :STRING => 15, :UNICODE_ESC => 16, 
                   :WS => 17 )

  end


  class Lexer < ANTLR3::Lexer
    @grammar_home = SfpLang
    include TokenData

    begin
      generated_using( "SfpLang.g", "3.5", "1.10.0" )
    rescue NoMethodError => error
      # ignore
    end

    RULE_NAMES   = [ "T__18", "T__19", "T__20", "T__21", "T__22", "T__23", 
                     "T__24", "T__25", "T__26", "T__27", "T__28", "T__29", 
                     "T__30", "T__31", "T__32", "T__33", "T__34", "T__35", 
                     "T__36", "T__37", "T__38", "T__39", "T__40", "T__41", 
                     "T__42", "T__43", "T__44", "T__45", "T__46", "T__47", 
                     "T__48", "T__49", "T__50", "T__51", "T__52", "T__53", 
                     "T__54", "T__55", "T__56", "T__57", "T__58", "T__59", 
                     "T__60", "T__61", "T__62", "T__63", "T__64", "T__65", 
                     "T__66", "T__67", "T__68", "T__69", "T__70", "T__71", 
                     "T__72", "T__73", "T__74", "T__75", "T__76", "T__77", 
                     "T__78", "T__79", "T__80", "T__81", "T__82", "T__83", 
                     "T__84", "T__85", "T__86", "NULL", "BOOLEAN", "ID", 
                     "NUMBER", "COMMENT", "MULTILINE_STRING", "NL", "WS", 
                     "STRING", "EXPONENT", "HEX_DIGIT", "ESC_SEQ", "OCTAL_ESC", 
                     "UNICODE_ESC" ].freeze
    RULE_METHODS = [ :t__18!, :t__19!, :t__20!, :t__21!, :t__22!, :t__23!, 
                     :t__24!, :t__25!, :t__26!, :t__27!, :t__28!, :t__29!, 
                     :t__30!, :t__31!, :t__32!, :t__33!, :t__34!, :t__35!, 
                     :t__36!, :t__37!, :t__38!, :t__39!, :t__40!, :t__41!, 
                     :t__42!, :t__43!, :t__44!, :t__45!, :t__46!, :t__47!, 
                     :t__48!, :t__49!, :t__50!, :t__51!, :t__52!, :t__53!, 
                     :t__54!, :t__55!, :t__56!, :t__57!, :t__58!, :t__59!, 
                     :t__60!, :t__61!, :t__62!, :t__63!, :t__64!, :t__65!, 
                     :t__66!, :t__67!, :t__68!, :t__69!, :t__70!, :t__71!, 
                     :t__72!, :t__73!, :t__74!, :t__75!, :t__76!, :t__77!, 
                     :t__78!, :t__79!, :t__80!, :t__81!, :t__82!, :t__83!, 
                     :t__84!, :t__85!, :t__86!, :null!, :boolean!, :id!, 
                     :number!, :comment!, :multiline_string!, :nl!, :ws!, 
                     :string!, :exponent!, :hex_digit!, :esc_seq!, :octal_esc!, 
                     :unicode_esc! ].freeze

    def initialize( input=nil, options = {} )
      super( input, options )
    end


    # - - - - - - - - - - - lexer rules - - - - - - - - - - - -
    # lexer rule t__18! (T__18)
    # (in SfpLang.g)
    def t__18!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 1 )



      type = T__18
      channel = ANTLR3::DEFAULT_CHANNEL
    # - - - - label initialization - - - -


      # - - - - main rule block - - - -
      # at line 7:9: '!'
      match( 0x21 )


      @state.type = type
      @state.channel = channel
    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 1 )


    end

    # lexer rule t__19! (T__19)
    # (in SfpLang.g)
    def t__19!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 2 )



      type = T__19
      channel = ANTLR3::DEFAULT_CHANNEL
    # - - - - label initialization - - - -


      # - - - - main rule block - - - -
      # at line 8:9: '!='
      match( "!=" )



      @state.type = type
      @state.channel = channel
    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 2 )


    end

    # lexer rule t__20! (T__20)
    # (in SfpLang.g)
    def t__20!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 3 )



      type = T__20
      channel = ANTLR3::DEFAULT_CHANNEL
    # - - - - label initialization - - - -


      # - - - - main rule block - - - -
      # at line 9:9: '('
      match( 0x28 )


      @state.type = type
      @state.channel = channel
    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 3 )


    end

    # lexer rule t__21! (T__21)
    # (in SfpLang.g)
    def t__21!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 4 )



      type = T__21
      channel = ANTLR3::DEFAULT_CHANNEL
    # - - - - label initialization - - - -


      # - - - - main rule block - - - -
      # at line 10:9: ')'
      match( 0x29 )


      @state.type = type
      @state.channel = channel
    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 4 )


    end

    # lexer rule t__22! (T__22)
    # (in SfpLang.g)
    def t__22!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 5 )



      type = T__22
      channel = ANTLR3::DEFAULT_CHANNEL
    # - - - - label initialization - - - -


      # - - - - main rule block - - - -
      # at line 11:9: '*='
      match( "*=" )



      @state.type = type
      @state.channel = channel
    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 5 )


    end

    # lexer rule t__23! (T__23)
    # (in SfpLang.g)
    def t__23!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 6 )



      type = T__23
      channel = ANTLR3::DEFAULT_CHANNEL
    # - - - - label initialization - - - -


      # - - - - main rule block - - - -
      # at line 12:9: '+='
      match( "+=" )



      @state.type = type
      @state.channel = channel
    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 6 )


    end

    # lexer rule t__24! (T__24)
    # (in SfpLang.g)
    def t__24!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 7 )



      type = T__24
      channel = ANTLR3::DEFAULT_CHANNEL
    # - - - - label initialization - - - -


      # - - - - main rule block - - - -
      # at line 13:9: ','
      match( 0x2c )


      @state.type = type
      @state.channel = channel
    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 7 )


    end

    # lexer rule t__25! (T__25)
    # (in SfpLang.g)
    def t__25!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 8 )



      type = T__25
      channel = ANTLR3::DEFAULT_CHANNEL
    # - - - - label initialization - - - -


      # - - - - main rule block - - - -
      # at line 14:9: '-='
      match( "-=" )



      @state.type = type
      @state.channel = channel
    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 8 )


    end

    # lexer rule t__26! (T__26)
    # (in SfpLang.g)
    def t__26!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 9 )



      type = T__26
      channel = ANTLR3::DEFAULT_CHANNEL
    # - - - - label initialization - - - -


      # - - - - main rule block - - - -
      # at line 15:9: '.'
      match( 0x2e )


      @state.type = type
      @state.channel = channel
    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 9 )


    end

    # lexer rule t__27! (T__27)
    # (in SfpLang.g)
    def t__27!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 10 )



      type = T__27
      channel = ANTLR3::DEFAULT_CHANNEL
    # - - - - label initialization - - - -


      # - - - - main rule block - - - -
      # at line 16:9: '/='
      match( "/=" )



      @state.type = type
      @state.channel = channel
    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 10 )


    end

    # lexer rule t__28! (T__28)
    # (in SfpLang.g)
    def t__28!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 11 )



      type = T__28
      channel = ANTLR3::DEFAULT_CHANNEL
    # - - - - label initialization - - - -


      # - - - - main rule block - - - -
      # at line 17:9: ':'
      match( 0x3a )


      @state.type = type
      @state.channel = channel
    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 11 )


    end

    # lexer rule t__29! (T__29)
    # (in SfpLang.g)
    def t__29!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 12 )



      type = T__29
      channel = ANTLR3::DEFAULT_CHANNEL
    # - - - - label initialization - - - -


      # - - - - main rule block - - - -
      # at line 18:9: ':different'
      match( ":different" )



      @state.type = type
      @state.channel = channel
    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 12 )


    end

    # lexer rule t__30! (T__30)
    # (in SfpLang.g)
    def t__30!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 13 )



      type = T__30
      channel = ANTLR3::DEFAULT_CHANNEL
    # - - - - label initialization - - - -


      # - - - - main rule block - - - -
      # at line 19:9: '<'
      match( 0x3c )


      @state.type = type
      @state.channel = channel
    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 13 )


    end

    # lexer rule t__31! (T__31)
    # (in SfpLang.g)
    def t__31!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 14 )



      type = T__31
      channel = ANTLR3::DEFAULT_CHANNEL
    # - - - - label initialization - - - -


      # - - - - main rule block - - - -
      # at line 20:9: '<='
      match( "<=" )



      @state.type = type
      @state.channel = channel
    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 14 )


    end

    # lexer rule t__32! (T__32)
    # (in SfpLang.g)
    def t__32!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 15 )



      type = T__32
      channel = ANTLR3::DEFAULT_CHANNEL
    # - - - - label initialization - - - -


      # - - - - main rule block - - - -
      # at line 21:9: '='
      match( 0x3d )


      @state.type = type
      @state.channel = channel
    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 15 )


    end

    # lexer rule t__33! (T__33)
    # (in SfpLang.g)
    def t__33!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 16 )



      type = T__33
      channel = ANTLR3::DEFAULT_CHANNEL
    # - - - - label initialization - - - -


      # - - - - main rule block - - - -
      # at line 22:9: '>'
      match( 0x3e )


      @state.type = type
      @state.channel = channel
    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 16 )


    end

    # lexer rule t__34! (T__34)
    # (in SfpLang.g)
    def t__34!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 17 )



      type = T__34
      channel = ANTLR3::DEFAULT_CHANNEL
    # - - - - label initialization - - - -


      # - - - - main rule block - - - -
      # at line 23:9: '>='
      match( ">=" )



      @state.type = type
      @state.channel = channel
    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 17 )


    end

    # lexer rule t__35! (T__35)
    # (in SfpLang.g)
    def t__35!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 18 )



      type = T__35
      channel = ANTLR3::DEFAULT_CHANNEL
    # - - - - label initialization - - - -


      # - - - - main rule block - - - -
      # at line 24:9: '['
      match( 0x5b )


      @state.type = type
      @state.channel = channel
    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 18 )


    end

    # lexer rule t__36! (T__36)
    # (in SfpLang.g)
    def t__36!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 19 )



      type = T__36
      channel = ANTLR3::DEFAULT_CHANNEL
    # - - - - label initialization - - - -


      # - - - - main rule block - - - -
      # at line 25:9: ']'
      match( 0x5d )


      @state.type = type
      @state.channel = channel
    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 19 )


    end

    # lexer rule t__37! (T__37)
    # (in SfpLang.g)
    def t__37!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 20 )



      type = T__37
      channel = ANTLR3::DEFAULT_CHANNEL
    # - - - - label initialization - - - -


      # - - - - main rule block - - - -
      # at line 26:9: 'abstract'
      match( "abstract" )



      @state.type = type
      @state.channel = channel
    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 20 )


    end

    # lexer rule t__38! (T__38)
    # (in SfpLang.g)
    def t__38!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 21 )



      type = T__38
      channel = ANTLR3::DEFAULT_CHANNEL
    # - - - - label initialization - - - -


      # - - - - main rule block - - - -
      # at line 27:9: 'add('
      match( "add(" )



      @state.type = type
      @state.channel = channel
    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 21 )


    end

    # lexer rule t__39! (T__39)
    # (in SfpLang.g)
    def t__39!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 22 )



      type = T__39
      channel = ANTLR3::DEFAULT_CHANNEL
    # - - - - label initialization - - - -


      # - - - - main rule block - - - -
      # at line 28:9: 'after'
      match( "after" )



      @state.type = type
      @state.channel = channel
    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 22 )


    end

    # lexer rule t__40! (T__40)
    # (in SfpLang.g)
    def t__40!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 23 )



      type = T__40
      channel = ANTLR3::DEFAULT_CHANNEL
    # - - - - label initialization - - - -


      # - - - - main rule block - - - -
      # at line 29:9: 'always'
      match( "always" )



      @state.type = type
      @state.channel = channel
    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 23 )


    end

    # lexer rule t__41! (T__41)
    # (in SfpLang.g)
    def t__41!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 24 )



      type = T__41
      channel = ANTLR3::DEFAULT_CHANNEL
    # - - - - label initialization - - - -


      # - - - - main rule block - - - -
      # at line 30:9: 'any'
      match( "any" )



      @state.type = type
      @state.channel = channel
    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 24 )


    end

    # lexer rule t__42! (T__42)
    # (in SfpLang.g)
    def t__42!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 25 )



      type = T__42
      channel = ANTLR3::DEFAULT_CHANNEL
    # - - - - label initialization - - - -


      # - - - - main rule block - - - -
      # at line 31:9: 'areall'
      match( "areall" )



      @state.type = type
      @state.channel = channel
    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 25 )


    end

    # lexer rule t__43! (T__43)
    # (in SfpLang.g)
    def t__43!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 26 )



      type = T__43
      channel = ANTLR3::DEFAULT_CHANNEL
    # - - - - label initialization - - - -


      # - - - - main rule block - - - -
      # at line 32:9: 'as'
      match( "as" )



      @state.type = type
      @state.channel = channel
    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 26 )


    end

    # lexer rule t__44! (T__44)
    # (in SfpLang.g)
    def t__44!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 27 )



      type = T__44
      channel = ANTLR3::DEFAULT_CHANNEL
    # - - - - label initialization - - - -


      # - - - - main rule block - - - -
      # at line 33:9: 'before'
      match( "before" )



      @state.type = type
      @state.channel = channel
    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 27 )


    end

    # lexer rule t__45! (T__45)
    # (in SfpLang.g)
    def t__45!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 28 )



      type = T__45
      channel = ANTLR3::DEFAULT_CHANNEL
    # - - - - label initialization - - - -


      # - - - - main rule block - - - -
      # at line 34:9: 'class'
      match( "class" )



      @state.type = type
      @state.channel = channel
    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 28 )


    end

    # lexer rule t__46! (T__46)
    # (in SfpLang.g)
    def t__46!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 29 )



      type = T__46
      channel = ANTLR3::DEFAULT_CHANNEL
    # - - - - label initialization - - - -


      # - - - - main rule block - - - -
      # at line 35:9: 'condition'
      match( "condition" )



      @state.type = type
      @state.channel = channel
    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 29 )


    end

    # lexer rule t__47! (T__47)
    # (in SfpLang.g)
    def t__47!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 30 )



      type = T__47
      channel = ANTLR3::DEFAULT_CHANNEL
    # - - - - label initialization - - - -


      # - - - - main rule block - - - -
      # at line 36:9: 'conditions'
      match( "conditions" )



      @state.type = type
      @state.channel = channel
    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 30 )


    end

    # lexer rule t__48! (T__48)
    # (in SfpLang.g)
    def t__48!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 31 )



      type = T__48
      channel = ANTLR3::DEFAULT_CHANNEL
    # - - - - label initialization - - - -


      # - - - - main rule block - - - -
      # at line 37:9: 'constraint'
      match( "constraint" )



      @state.type = type
      @state.channel = channel
    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 31 )


    end

    # lexer rule t__49! (T__49)
    # (in SfpLang.g)
    def t__49!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 32 )



      type = T__49
      channel = ANTLR3::DEFAULT_CHANNEL
    # - - - - label initialization - - - -


      # - - - - main rule block - - - -
      # at line 38:9: 'cost'
      match( "cost" )



      @state.type = type
      @state.channel = channel
    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 32 )


    end

    # lexer rule t__50! (T__50)
    # (in SfpLang.g)
    def t__50!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 33 )



      type = T__50
      channel = ANTLR3::DEFAULT_CHANNEL
    # - - - - label initialization - - - -


      # - - - - main rule block - - - -
      # at line 39:9: 'delete'
      match( "delete" )



      @state.type = type
      @state.channel = channel
    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 33 )


    end

    # lexer rule t__51! (T__51)
    # (in SfpLang.g)
    def t__51!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 34 )



      type = T__51
      channel = ANTLR3::DEFAULT_CHANNEL
    # - - - - label initialization - - - -


      # - - - - main rule block - - - -
      # at line 40:9: 'effect'
      match( "effect" )



      @state.type = type
      @state.channel = channel
    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 34 )


    end

    # lexer rule t__52! (T__52)
    # (in SfpLang.g)
    def t__52!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 35 )



      type = T__52
      channel = ANTLR3::DEFAULT_CHANNEL
    # - - - - label initialization - - - -


      # - - - - main rule block - - - -
      # at line 41:9: 'effects'
      match( "effects" )



      @state.type = type
      @state.channel = channel
    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 35 )


    end

    # lexer rule t__53! (T__53)
    # (in SfpLang.g)
    def t__53!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 36 )



      type = T__53
      channel = ANTLR3::DEFAULT_CHANNEL
    # - - - - label initialization - - - -


      # - - - - main rule block - - - -
      # at line 42:9: 'either'
      match( "either" )



      @state.type = type
      @state.channel = channel
    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 36 )


    end

    # lexer rule t__54! (T__54)
    # (in SfpLang.g)
    def t__54!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 37 )



      type = T__54
      channel = ANTLR3::DEFAULT_CHANNEL
    # - - - - label initialization - - - -


      # - - - - main rule block - - - -
      # at line 43:9: 'exist'
      match( "exist" )



      @state.type = type
      @state.channel = channel
    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 37 )


    end

    # lexer rule t__55! (T__55)
    # (in SfpLang.g)
    def t__55!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 38 )



      type = T__55
      channel = ANTLR3::DEFAULT_CHANNEL
    # - - - - label initialization - - - -


      # - - - - main rule block - - - -
      # at line 44:9: 'extends'
      match( "extends" )



      @state.type = type
      @state.channel = channel
    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 38 )


    end

    # lexer rule t__56! (T__56)
    # (in SfpLang.g)
    def t__56!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 39 )



      type = T__56
      channel = ANTLR3::DEFAULT_CHANNEL
    # - - - - label initialization - - - -


      # - - - - main rule block - - - -
      # at line 45:9: 'final'
      match( "final" )



      @state.type = type
      @state.channel = channel
    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 39 )


    end

    # lexer rule t__57! (T__57)
    # (in SfpLang.g)
    def t__57!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 40 )



      type = T__57
      channel = ANTLR3::DEFAULT_CHANNEL
    # - - - - label initialization - - - -


      # - - - - main rule block - - - -
      # at line 46:9: 'forall'
      match( "forall" )



      @state.type = type
      @state.channel = channel
    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 40 )


    end

    # lexer rule t__58! (T__58)
    # (in SfpLang.g)
    def t__58!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 41 )



      type = T__58
      channel = ANTLR3::DEFAULT_CHANNEL
    # - - - - label initialization - - - -


      # - - - - main rule block - - - -
      # at line 47:9: 'foreach'
      match( "foreach" )



      @state.type = type
      @state.channel = channel
    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 41 )


    end

    # lexer rule t__59! (T__59)
    # (in SfpLang.g)
    def t__59!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 42 )



      type = T__59
      channel = ANTLR3::DEFAULT_CHANNEL
    # - - - - label initialization - - - -


      # - - - - main rule block - - - -
      # at line 48:9: 'forsome'
      match( "forsome" )



      @state.type = type
      @state.channel = channel
    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 42 )


    end

    # lexer rule t__60! (T__60)
    # (in SfpLang.g)
    def t__60!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 43 )



      type = T__60
      channel = ANTLR3::DEFAULT_CHANNEL
    # - - - - label initialization - - - -


      # - - - - main rule block - - - -
      # at line 49:9: 'global'
      match( "global" )



      @state.type = type
      @state.channel = channel
    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 43 )


    end

    # lexer rule t__61! (T__61)
    # (in SfpLang.g)
    def t__61!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 44 )



      type = T__61
      channel = ANTLR3::DEFAULT_CHANNEL
    # - - - - label initialization - - - -


      # - - - - main rule block - - - -
      # at line 50:9: 'goal'
      match( "goal" )



      @state.type = type
      @state.channel = channel
    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 44 )


    end

    # lexer rule t__62! (T__62)
    # (in SfpLang.g)
    def t__62!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 45 )



      type = T__62
      channel = ANTLR3::DEFAULT_CHANNEL
    # - - - - label initialization - - - -


      # - - - - main rule block - - - -
      # at line 51:9: 'has'
      match( "has" )



      @state.type = type
      @state.channel = channel
    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 45 )


    end

    # lexer rule t__63! (T__63)
    # (in SfpLang.g)
    def t__63!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 46 )



      type = T__63
      channel = ANTLR3::DEFAULT_CHANNEL
    # - - - - label initialization - - - -


      # - - - - main rule block - - - -
      # at line 52:9: 'if'
      match( "if" )



      @state.type = type
      @state.channel = channel
    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 46 )


    end

    # lexer rule t__64! (T__64)
    # (in SfpLang.g)
    def t__64!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 47 )



      type = T__64
      channel = ANTLR3::DEFAULT_CHANNEL
    # - - - - label initialization - - - -


      # - - - - main rule block - - - -
      # at line 53:9: 'in'
      match( "in" )



      @state.type = type
      @state.channel = channel
    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 47 )


    end

    # lexer rule t__65! (T__65)
    # (in SfpLang.g)
    def t__65!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 48 )



      type = T__65
      channel = ANTLR3::DEFAULT_CHANNEL
    # - - - - label initialization - - - -


      # - - - - main rule block - - - -
      # at line 54:9: 'include'
      match( "include" )



      @state.type = type
      @state.channel = channel
    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 48 )


    end

    # lexer rule t__66! (T__66)
    # (in SfpLang.g)
    def t__66!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 49 )



      type = T__66
      channel = ANTLR3::DEFAULT_CHANNEL
    # - - - - label initialization - - - -


      # - - - - main rule block - - - -
      # at line 55:9: 'is'
      match( "is" )



      @state.type = type
      @state.channel = channel
    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 49 )


    end

    # lexer rule t__67! (T__67)
    # (in SfpLang.g)
    def t__67!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 50 )



      type = T__67
      channel = ANTLR3::DEFAULT_CHANNEL
    # - - - - label initialization - - - -


      # - - - - main rule block - - - -
      # at line 56:9: 'isa'
      match( "isa" )



      @state.type = type
      @state.channel = channel
    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 50 )


    end

    # lexer rule t__68! (T__68)
    # (in SfpLang.g)
    def t__68!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 51 )



      type = T__68
      channel = ANTLR3::DEFAULT_CHANNEL
    # - - - - label initialization - - - -


      # - - - - main rule block - - - -
      # at line 57:9: 'isnot'
      match( "isnot" )



      @state.type = type
      @state.channel = channel
    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 51 )


    end

    # lexer rule t__69! (T__69)
    # (in SfpLang.g)
    def t__69!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 52 )



      type = T__69
      channel = ANTLR3::DEFAULT_CHANNEL
    # - - - - label initialization - - - -


      # - - - - main rule block - - - -
      # at line 58:9: 'isnt'
      match( "isnt" )



      @state.type = type
      @state.channel = channel
    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 52 )


    end

    # lexer rule t__70! (T__70)
    # (in SfpLang.g)
    def t__70!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 53 )



      type = T__70
      channel = ANTLR3::DEFAULT_CHANNEL
    # - - - - label initialization - - - -


      # - - - - main rule block - - - -
      # at line 59:9: 'isref'
      match( "isref" )



      @state.type = type
      @state.channel = channel
    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 53 )


    end

    # lexer rule t__71! (T__71)
    # (in SfpLang.g)
    def t__71!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 54 )



      type = T__71
      channel = ANTLR3::DEFAULT_CHANNEL
    # - - - - label initialization - - - -


      # - - - - main rule block - - - -
      # at line 60:9: 'isset'
      match( "isset" )



      @state.type = type
      @state.channel = channel
    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 54 )


    end

    # lexer rule t__72! (T__72)
    # (in SfpLang.g)
    def t__72!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 55 )



      type = T__72
      channel = ANTLR3::DEFAULT_CHANNEL
    # - - - - label initialization - - - -


      # - - - - main rule block - - - -
      # at line 61:9: 'new'
      match( "new" )



      @state.type = type
      @state.channel = channel
    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 55 )


    end

    # lexer rule t__73! (T__73)
    # (in SfpLang.g)
    def t__73!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 56 )



      type = T__73
      channel = ANTLR3::DEFAULT_CHANNEL
    # - - - - label initialization - - - -


      # - - - - main rule block - - - -
      # at line 62:9: 'not'
      match( "not" )



      @state.type = type
      @state.channel = channel
    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 56 )


    end

    # lexer rule t__74! (T__74)
    # (in SfpLang.g)
    def t__74!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 57 )



      type = T__74
      channel = ANTLR3::DEFAULT_CHANNEL
    # - - - - label initialization - - - -


      # - - - - main rule block - - - -
      # at line 63:9: 'or'
      match( "or" )



      @state.type = type
      @state.channel = channel
    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 57 )


    end

    # lexer rule t__75! (T__75)
    # (in SfpLang.g)
    def t__75!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 58 )



      type = T__75
      channel = ANTLR3::DEFAULT_CHANNEL
    # - - - - label initialization - - - -


      # - - - - main rule block - - - -
      # at line 64:9: 'procedure'
      match( "procedure" )



      @state.type = type
      @state.channel = channel
    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 58 )


    end

    # lexer rule t__76! (T__76)
    # (in SfpLang.g)
    def t__76!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 59 )



      type = T__76
      channel = ANTLR3::DEFAULT_CHANNEL
    # - - - - label initialization - - - -


      # - - - - main rule block - - - -
      # at line 65:9: 'remove('
      match( "remove(" )



      @state.type = type
      @state.channel = channel
    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 59 )


    end

    # lexer rule t__77! (T__77)
    # (in SfpLang.g)
    def t__77!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 60 )



      type = T__77
      channel = ANTLR3::DEFAULT_CHANNEL
    # - - - - label initialization - - - -


      # - - - - main rule block - - - -
      # at line 66:9: 'schema'
      match( "schema" )



      @state.type = type
      @state.channel = channel
    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 60 )


    end

    # lexer rule t__78! (T__78)
    # (in SfpLang.g)
    def t__78!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 61 )



      type = T__78
      channel = ANTLR3::DEFAULT_CHANNEL
    # - - - - label initialization - - - -


      # - - - - main rule block - - - -
      # at line 67:9: 'sometime'
      match( "sometime" )



      @state.type = type
      @state.channel = channel
    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 61 )


    end

    # lexer rule t__79! (T__79)
    # (in SfpLang.g)
    def t__79!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 62 )



      type = T__79
      channel = ANTLR3::DEFAULT_CHANNEL
    # - - - - label initialization - - - -


      # - - - - main rule block - - - -
      # at line 68:9: 'state'
      match( "state" )



      @state.type = type
      @state.channel = channel
    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 62 )


    end

    # lexer rule t__80! (T__80)
    # (in SfpLang.g)
    def t__80!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 63 )



      type = T__80
      channel = ANTLR3::DEFAULT_CHANNEL
    # - - - - label initialization - - - -


      # - - - - main rule block - - - -
      # at line 69:9: 'sub'
      match( "sub" )



      @state.type = type
      @state.channel = channel
    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 63 )


    end

    # lexer rule t__81! (T__81)
    # (in SfpLang.g)
    def t__81!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 64 )



      type = T__81
      channel = ANTLR3::DEFAULT_CHANNEL
    # - - - - label initialization - - - -


      # - - - - main rule block - - - -
      # at line 70:9: 'synchronized'
      match( "synchronized" )



      @state.type = type
      @state.channel = channel
    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 64 )


    end

    # lexer rule t__82! (T__82)
    # (in SfpLang.g)
    def t__82!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 65 )



      type = T__82
      channel = ANTLR3::DEFAULT_CHANNEL
    # - - - - label initialization - - - -


      # - - - - main rule block - - - -
      # at line 71:9: 'then'
      match( "then" )



      @state.type = type
      @state.channel = channel
    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 65 )


    end

    # lexer rule t__83! (T__83)
    # (in SfpLang.g)
    def t__83!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 66 )



      type = T__83
      channel = ANTLR3::DEFAULT_CHANNEL
    # - - - - label initialization - - - -


      # - - - - main rule block - - - -
      # at line 72:9: 'total('
      match( "total(" )



      @state.type = type
      @state.channel = channel
    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 66 )


    end

    # lexer rule t__84! (T__84)
    # (in SfpLang.g)
    def t__84!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 67 )



      type = T__84
      channel = ANTLR3::DEFAULT_CHANNEL
    # - - - - label initialization - - - -


      # - - - - main rule block - - - -
      # at line 73:9: 'within'
      match( "within" )



      @state.type = type
      @state.channel = channel
    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 67 )


    end

    # lexer rule t__85! (T__85)
    # (in SfpLang.g)
    def t__85!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 68 )



      type = T__85
      channel = ANTLR3::DEFAULT_CHANNEL
    # - - - - label initialization - - - -


      # - - - - main rule block - - - -
      # at line 74:9: '{'
      match( 0x7b )


      @state.type = type
      @state.channel = channel
    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 68 )


    end

    # lexer rule t__86! (T__86)
    # (in SfpLang.g)
    def t__86!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 69 )



      type = T__86
      channel = ANTLR3::DEFAULT_CHANNEL
    # - - - - label initialization - - - -


      # - - - - main rule block - - - -
      # at line 75:9: '}'
      match( 0x7d )


      @state.type = type
      @state.channel = channel
    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 69 )


    end

    # lexer rule null! (NULL)
    # (in SfpLang.g)
    def null!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 70 )



      type = NULL
      channel = ANTLR3::DEFAULT_CHANNEL
    # - - - - label initialization - - - -


      # - - - - main rule block - - - -
      # at line 1017:2: ( 'null' | 'nil' )
      alt_1 = 2
      look_1_0 = @input.peek( 1 )

      if ( look_1_0 == 0x6e )
        look_1_1 = @input.peek( 2 )

        if ( look_1_1 == 0x75 )
          alt_1 = 1
        elsif ( look_1_1 == 0x69 )
          alt_1 = 2
        else
          raise NoViableAlternative( "", 1, 1 )

        end
      else
        raise NoViableAlternative( "", 1, 0 )

      end
      case alt_1
      when 1
        # at line 1017:4: 'null'
        match( "null" )


      when 2
        # at line 1018:4: 'nil'
        match( "nil" )


      end

      @state.type = type
      @state.channel = channel
    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 70 )


    end

    # lexer rule boolean! (BOOLEAN)
    # (in SfpLang.g)
    def boolean!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 71 )



      type = BOOLEAN
      channel = ANTLR3::DEFAULT_CHANNEL
    # - - - - label initialization - - - -


      # - - - - main rule block - - - -
      # at line 1022:2: ( 'true' | 'false' | 'off' | 'on' | 'yes' | 'no' )
      alt_2 = 6
      case look_2 = @input.peek( 1 )
      when 0x74 then alt_2 = 1
      when 0x66 then alt_2 = 2
      when 0x6f then look_2_3 = @input.peek( 2 )

      if ( look_2_3 == 0x66 )
        alt_2 = 3
      elsif ( look_2_3 == 0x6e )
        alt_2 = 4
      else
        raise NoViableAlternative( "", 2, 3 )

      end
      when 0x79 then alt_2 = 5
      when 0x6e then alt_2 = 6
      else
        raise NoViableAlternative( "", 2, 0 )

      end
      case alt_2
      when 1
        # at line 1022:4: 'true'
        match( "true" )


      when 2
        # at line 1023:4: 'false'
        match( "false" )


      when 3
        # at line 1024:4: 'off'
        match( "off" )


      when 4
        # at line 1025:4: 'on'
        match( "on" )


      when 5
        # at line 1026:4: 'yes'
        match( "yes" )


      when 6
        # at line 1027:4: 'no'
        match( "no" )


      end

      @state.type = type
      @state.channel = channel
    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 71 )


    end

    # lexer rule id! (ID)
    # (in SfpLang.g)
    def id!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 72 )



      type = ID
      channel = ANTLR3::DEFAULT_CHANNEL
    # - - - - label initialization - - - -


      # - - - - main rule block - - - -
      # at line 1030:6: ( 'a' .. 'z' | 'A' .. 'Z' ) ( 'a' .. 'z' | 'A' .. 'Z' | '0' .. '9' | '_' )*
      if @input.peek( 1 ).between?( 0x41, 0x5a ) || @input.peek( 1 ).between?( 0x61, 0x7a )
        @input.consume
      else
        mse = MismatchedSet( nil )
        recover mse
        raise mse

      end


      # at line 1030:25: ( 'a' .. 'z' | 'A' .. 'Z' | '0' .. '9' | '_' )*
      while true # decision 3
        alt_3 = 2
        look_3_0 = @input.peek( 1 )

        if ( look_3_0.between?( 0x30, 0x39 ) || look_3_0.between?( 0x41, 0x5a ) || look_3_0 == 0x5f || look_3_0.between?( 0x61, 0x7a ) )
          alt_3 = 1

        end
        case alt_3
        when 1
          # at line 
          if @input.peek( 1 ).between?( 0x30, 0x39 ) || @input.peek( 1 ).between?( 0x41, 0x5a ) || @input.peek(1) == 0x5f || @input.peek( 1 ).between?( 0x61, 0x7a )
            @input.consume
          else
            mse = MismatchedSet( nil )
            recover mse
            raise mse

          end



        else
          break # out of loop for decision 3
        end
      end # loop for decision 3



      @state.type = type
      @state.channel = channel
    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 72 )


    end

    # lexer rule number! (NUMBER)
    # (in SfpLang.g)
    def number!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 73 )



      type = NUMBER
      channel = ANTLR3::DEFAULT_CHANNEL
    # - - - - label initialization - - - -


      # - - - - main rule block - - - -
      # at line 1034:4: ( '-' )? ( '0' .. '9' )+
      # at line 1034:4: ( '-' )?
      alt_4 = 2
      look_4_0 = @input.peek( 1 )

      if ( look_4_0 == 0x2d )
        alt_4 = 1
      end
      case alt_4
      when 1
        # at line 1034:4: '-'
        match( 0x2d )

      end
      # at file 1034:8: ( '0' .. '9' )+
      match_count_5 = 0
      while true
        alt_5 = 2
        look_5_0 = @input.peek( 1 )

        if ( look_5_0.between?( 0x30, 0x39 ) )
          alt_5 = 1

        end
        case alt_5
        when 1
          # at line 
          if @input.peek( 1 ).between?( 0x30, 0x39 )
            @input.consume
          else
            mse = MismatchedSet( nil )
            recover mse
            raise mse

          end



        else
          match_count_5 > 0 and break
          eee = EarlyExit(5)


          raise eee
        end
        match_count_5 += 1
      end




      @state.type = type
      @state.channel = channel
    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 73 )


    end

    # lexer rule comment! (COMMENT)
    # (in SfpLang.g)
    def comment!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 74 )



      type = COMMENT
      channel = ANTLR3::DEFAULT_CHANNEL
    # - - - - label initialization - - - -


      # - - - - main rule block - - - -
      # at line 1045:2: ( '//' (~ ( '\\n' | '\\r' ) )* | '#' (~ ( '\\n' | '\\r' ) )* | '/*' ( options {greedy=false; } : . )* '*/' )
      alt_9 = 3
      look_9_0 = @input.peek( 1 )

      if ( look_9_0 == 0x2f )
        look_9_1 = @input.peek( 2 )

        if ( look_9_1 == 0x2f )
          alt_9 = 1
        elsif ( look_9_1 == 0x2a )
          alt_9 = 3
        else
          raise NoViableAlternative( "", 9, 1 )

        end
      elsif ( look_9_0 == 0x23 )
        alt_9 = 2
      else
        raise NoViableAlternative( "", 9, 0 )

      end
      case alt_9
      when 1
        # at line 1045:4: '//' (~ ( '\\n' | '\\r' ) )*
        match( "//" )

        # at line 1045:9: (~ ( '\\n' | '\\r' ) )*
        while true # decision 6
          alt_6 = 2
          look_6_0 = @input.peek( 1 )

          if ( look_6_0.between?( 0x0, 0x9 ) || look_6_0.between?( 0xb, 0xc ) || look_6_0.between?( 0xe, 0xffff ) )
            alt_6 = 1

          end
          case alt_6
          when 1
            # at line 
            if @input.peek( 1 ).between?( 0x0, 0x9 ) || @input.peek( 1 ).between?( 0xb, 0xc ) || @input.peek( 1 ).between?( 0xe, 0xffff )
              @input.consume
            else
              mse = MismatchedSet( nil )
              recover mse
              raise mse

            end



          else
            break # out of loop for decision 6
          end
        end # loop for decision 6


        # --> action
        channel=HIDDEN;
        # <-- action


      when 2
        # at line 1046:4: '#' (~ ( '\\n' | '\\r' ) )*
        match( 0x23 )
        # at line 1046:8: (~ ( '\\n' | '\\r' ) )*
        while true # decision 7
          alt_7 = 2
          look_7_0 = @input.peek( 1 )

          if ( look_7_0.between?( 0x0, 0x9 ) || look_7_0.between?( 0xb, 0xc ) || look_7_0.between?( 0xe, 0xffff ) )
            alt_7 = 1

          end
          case alt_7
          when 1
            # at line 
            if @input.peek( 1 ).between?( 0x0, 0x9 ) || @input.peek( 1 ).between?( 0xb, 0xc ) || @input.peek( 1 ).between?( 0xe, 0xffff )
              @input.consume
            else
              mse = MismatchedSet( nil )
              recover mse
              raise mse

            end



          else
            break # out of loop for decision 7
          end
        end # loop for decision 7


        # --> action
        channel=HIDDEN;
        # <-- action


      when 3
        # at line 1047:4: '/*' ( options {greedy=false; } : . )* '*/'
        match( "/*" )

        # at line 1047:9: ( options {greedy=false; } : . )*
        while true # decision 8
          alt_8 = 2
          look_8_0 = @input.peek( 1 )

          if ( look_8_0 == 0x2a )
            look_8_1 = @input.peek( 2 )

            if ( look_8_1 == 0x2f )
              alt_8 = 2
            elsif ( look_8_1.between?( 0x0, 0x2e ) || look_8_1.between?( 0x30, 0xffff ) )
              alt_8 = 1

            end
          elsif ( look_8_0.between?( 0x0, 0x29 ) || look_8_0.between?( 0x2b, 0xffff ) )
            alt_8 = 1

          end
          case alt_8
          when 1
            # at line 1047:37: .
            match_any

          else
            break # out of loop for decision 8
          end
        end # loop for decision 8


        match( "*/" )


        # --> action
        channel=HIDDEN;
        # <-- action


      end

      @state.type = type
      @state.channel = channel
    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 74 )


    end

    # lexer rule multiline_string! (MULTILINE_STRING)
    # (in SfpLang.g)
    def multiline_string!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 75 )



      type = MULTILINE_STRING
      channel = ANTLR3::DEFAULT_CHANNEL
    # - - - - label initialization - - - -


      # - - - - main rule block - - - -
      # at line 1051:4: 'r\"' ( options {greedy=false; } : . )* '\"'
      match( "r\"" )

      # at line 1051:9: ( options {greedy=false; } : . )*
      while true # decision 10
        alt_10 = 2
        look_10_0 = @input.peek( 1 )

        if ( look_10_0 == 0x22 )
          alt_10 = 2
        elsif ( look_10_0.between?( 0x0, 0x21 ) || look_10_0.between?( 0x23, 0xffff ) )
          alt_10 = 1

        end
        case alt_10
        when 1
          # at line 1051:37: .
          match_any

        else
          break # out of loop for decision 10
        end
      end # loop for decision 10

      match( 0x22 )


      @state.type = type
      @state.channel = channel
    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 75 )


    end

    # lexer rule nl! (NL)
    # (in SfpLang.g)
    def nl!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 76 )



      type = NL
      channel = ANTLR3::DEFAULT_CHANNEL
    # - - - - label initialization - - - -


      # - - - - main rule block - - - -
      # at line 1054:6: ( ( '\\r' )? '\\n' | ';' )
      # at line 1054:6: ( ( '\\r' )? '\\n' | ';' )
      alt_12 = 2
      look_12_0 = @input.peek( 1 )

      if ( look_12_0 == 0xa || look_12_0 == 0xd )
        alt_12 = 1
      elsif ( look_12_0 == 0x3b )
        alt_12 = 2
      else
        raise NoViableAlternative( "", 12, 0 )

      end
      case alt_12
      when 1
        # at line 1054:7: ( '\\r' )? '\\n'
        # at line 1054:7: ( '\\r' )?
        alt_11 = 2
        look_11_0 = @input.peek( 1 )

        if ( look_11_0 == 0xd )
          alt_11 = 1
        end
        case alt_11
        when 1
          # at line 1054:7: '\\r'
          match( 0xd )

        end
        match( 0xa )

      when 2
        # at line 1054:18: ';'
        match( 0x3b )

      end


      @state.type = type
      @state.channel = channel
    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 76 )


    end

    # lexer rule ws! (WS)
    # (in SfpLang.g)
    def ws!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 77 )



      type = WS
      channel = ANTLR3::DEFAULT_CHANNEL
    # - - - - label initialization - - - -


      # - - - - main rule block - - - -
      # at line 1057:8: ( ' ' | '\\t' )
      if @input.peek(1) == 0x9 || @input.peek(1) == 0x20
        @input.consume
      else
        mse = MismatchedSet( nil )
        recover mse
        raise mse

      end



      # --> action
      channel=HIDDEN;
      # <-- action



      @state.type = type
      @state.channel = channel
    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 77 )


    end

    # lexer rule string! (STRING)
    # (in SfpLang.g)
    def string!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 78 )



      type = STRING
      channel = ANTLR3::DEFAULT_CHANNEL
    # - - - - label initialization - - - -


      # - - - - main rule block - - - -
      # at line 1061:5: '\"' ( ESC_SEQ |~ ( '\\\\' | '\"' ) )* '\"'
      match( 0x22 )
      # at line 1061:9: ( ESC_SEQ |~ ( '\\\\' | '\"' ) )*
      while true # decision 13
        alt_13 = 3
        look_13_0 = @input.peek( 1 )

        if ( look_13_0 == 0x5c )
          alt_13 = 1
        elsif ( look_13_0.between?( 0x0, 0x21 ) || look_13_0.between?( 0x23, 0x5b ) || look_13_0.between?( 0x5d, 0xffff ) )
          alt_13 = 2

        end
        case alt_13
        when 1
          # at line 1061:11: ESC_SEQ
          esc_seq!


        when 2
          # at line 1061:21: ~ ( '\\\\' | '\"' )
          if @input.peek( 1 ).between?( 0x0, 0x21 ) || @input.peek( 1 ).between?( 0x23, 0x5b ) || @input.peek( 1 ).between?( 0x5d, 0xff )
            @input.consume
          else
            mse = MismatchedSet( nil )
            recover mse
            raise mse

          end



        else
          break # out of loop for decision 13
        end
      end # loop for decision 13

      match( 0x22 )


      @state.type = type
      @state.channel = channel
    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 78 )


    end

    # lexer rule exponent! (EXPONENT)
    # (in SfpLang.g)
    def exponent!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 79 )


    # - - - - label initialization - - - -


      # - - - - main rule block - - - -
      # at line 1066:12: ( 'e' | 'E' ) ( '+' | '-' )? ( '0' .. '9' )+
      if @input.peek(1) == 0x45 || @input.peek(1) == 0x65
        @input.consume
      else
        mse = MismatchedSet( nil )
        recover mse
        raise mse

      end


      # at line 1066:22: ( '+' | '-' )?
      alt_14 = 2
      look_14_0 = @input.peek( 1 )

      if ( look_14_0 == 0x2b || look_14_0 == 0x2d )
        alt_14 = 1
      end
      case alt_14
      when 1
        # at line 
        if @input.peek(1) == 0x2b || @input.peek(1) == 0x2d
          @input.consume
        else
          mse = MismatchedSet( nil )
          recover mse
          raise mse

        end



      end
      # at file 1066:33: ( '0' .. '9' )+
      match_count_15 = 0
      while true
        alt_15 = 2
        look_15_0 = @input.peek( 1 )

        if ( look_15_0.between?( 0x30, 0x39 ) )
          alt_15 = 1

        end
        case alt_15
        when 1
          # at line 
          if @input.peek( 1 ).between?( 0x30, 0x39 )
            @input.consume
          else
            mse = MismatchedSet( nil )
            recover mse
            raise mse

          end



        else
          match_count_15 > 0 and break
          eee = EarlyExit(15)


          raise eee
        end
        match_count_15 += 1
      end



    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 79 )


    end

    # lexer rule hex_digit! (HEX_DIGIT)
    # (in SfpLang.g)
    def hex_digit!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 80 )


    # - - - - label initialization - - - -


      # - - - - main rule block - - - -
      # at line 
      if @input.peek( 1 ).between?( 0x30, 0x39 ) || @input.peek( 1 ).between?( 0x41, 0x46 ) || @input.peek( 1 ).between?( 0x61, 0x66 )
        @input.consume
      else
        mse = MismatchedSet( nil )
        recover mse
        raise mse

      end



    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 80 )


    end

    # lexer rule esc_seq! (ESC_SEQ)
    # (in SfpLang.g)
    def esc_seq!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 81 )


    # - - - - label initialization - - - -


      # - - - - main rule block - - - -
      # at line 1073:2: ( '\\\\' ( 'b' | 't' | 'n' | 'f' | 'r' | '\\\"' | '\\'' | '\\\\' ) | UNICODE_ESC | OCTAL_ESC )
      alt_16 = 3
      look_16_0 = @input.peek( 1 )

      if ( look_16_0 == 0x5c )
        case look_16 = @input.peek( 2 )
        when 0x22, 0x27, 0x5c, 0x62, 0x66, 0x6e, 0x72, 0x74 then alt_16 = 1
        when 0x75 then alt_16 = 2
        when 0x30, 0x31, 0x32, 0x33, 0x34, 0x35, 0x36, 0x37 then alt_16 = 3
        else
          raise NoViableAlternative( "", 16, 1 )

        end
      else
        raise NoViableAlternative( "", 16, 0 )

      end
      case alt_16
      when 1
        # at line 1073:6: '\\\\' ( 'b' | 't' | 'n' | 'f' | 'r' | '\\\"' | '\\'' | '\\\\' )
        match( 0x5c )
        if @input.peek(1) == 0x22 || @input.peek(1) == 0x27 || @input.peek(1) == 0x5c || @input.peek(1) == 0x62 || @input.peek(1) == 0x66 || @input.peek(1) == 0x6e || @input.peek(1) == 0x72 || @input.peek(1) == 0x74
          @input.consume
        else
          mse = MismatchedSet( nil )
          recover mse
          raise mse

        end



      when 2
        # at line 1074:6: UNICODE_ESC
        unicode_esc!


      when 3
        # at line 1075:6: OCTAL_ESC
        octal_esc!


      end
    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 81 )


    end

    # lexer rule octal_esc! (OCTAL_ESC)
    # (in SfpLang.g)
    def octal_esc!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 82 )


    # - - - - label initialization - - - -


      # - - - - main rule block - - - -
      # at line 1080:2: ( '\\\\' ( '0' .. '3' ) ( '0' .. '7' ) ( '0' .. '7' ) | '\\\\' ( '0' .. '7' ) ( '0' .. '7' ) | '\\\\' ( '0' .. '7' ) )
      alt_17 = 3
      look_17_0 = @input.peek( 1 )

      if ( look_17_0 == 0x5c )
        look_17_1 = @input.peek( 2 )

        if ( look_17_1.between?( 0x30, 0x33 ) )
          look_17_2 = @input.peek( 3 )

          if ( look_17_2.between?( 0x30, 0x37 ) )
            look_17_4 = @input.peek( 4 )

            if ( look_17_4.between?( 0x30, 0x37 ) )
              alt_17 = 1
            else
              alt_17 = 2

            end
          else
            alt_17 = 3

          end
        elsif ( look_17_1.between?( 0x34, 0x37 ) )
          look_17_3 = @input.peek( 3 )

          if ( look_17_3.between?( 0x30, 0x37 ) )
            alt_17 = 2
          else
            alt_17 = 3

          end
        else
          raise NoViableAlternative( "", 17, 1 )

        end
      else
        raise NoViableAlternative( "", 17, 0 )

      end
      case alt_17
      when 1
        # at line 1080:6: '\\\\' ( '0' .. '3' ) ( '0' .. '7' ) ( '0' .. '7' )
        match( 0x5c )
        if @input.peek( 1 ).between?( 0x30, 0x33 )
          @input.consume
        else
          mse = MismatchedSet( nil )
          recover mse
          raise mse

        end


        if @input.peek( 1 ).between?( 0x30, 0x37 )
          @input.consume
        else
          mse = MismatchedSet( nil )
          recover mse
          raise mse

        end


        if @input.peek( 1 ).between?( 0x30, 0x37 )
          @input.consume
        else
          mse = MismatchedSet( nil )
          recover mse
          raise mse

        end



      when 2
        # at line 1081:6: '\\\\' ( '0' .. '7' ) ( '0' .. '7' )
        match( 0x5c )
        if @input.peek( 1 ).between?( 0x30, 0x37 )
          @input.consume
        else
          mse = MismatchedSet( nil )
          recover mse
          raise mse

        end


        if @input.peek( 1 ).between?( 0x30, 0x37 )
          @input.consume
        else
          mse = MismatchedSet( nil )
          recover mse
          raise mse

        end



      when 3
        # at line 1082:6: '\\\\' ( '0' .. '7' )
        match( 0x5c )
        if @input.peek( 1 ).between?( 0x30, 0x37 )
          @input.consume
        else
          mse = MismatchedSet( nil )
          recover mse
          raise mse

        end



      end
    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 82 )


    end

    # lexer rule unicode_esc! (UNICODE_ESC)
    # (in SfpLang.g)
    def unicode_esc!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 83 )


    # - - - - label initialization - - - -


      # - - - - main rule block - - - -
      # at line 1087:6: '\\\\' 'u' HEX_DIGIT HEX_DIGIT HEX_DIGIT HEX_DIGIT
      match( 0x5c )
      match( 0x75 )

      hex_digit!


      hex_digit!


      hex_digit!


      hex_digit!


    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 83 )


    end

    # main rule used to study the input at the current position,
    # and choose the proper lexer rule to call in order to
    # fetch the next token
    #
    # usually, you don't make direct calls to this method,
    # but instead use the next_token method, which will
    # build and emit the actual next token
    def token!
      # at line 1:8: ( T__18 | T__19 | T__20 | T__21 | T__22 | T__23 | T__24 | T__25 | T__26 | T__27 | T__28 | T__29 | T__30 | T__31 | T__32 | T__33 | T__34 | T__35 | T__36 | T__37 | T__38 | T__39 | T__40 | T__41 | T__42 | T__43 | T__44 | T__45 | T__46 | T__47 | T__48 | T__49 | T__50 | T__51 | T__52 | T__53 | T__54 | T__55 | T__56 | T__57 | T__58 | T__59 | T__60 | T__61 | T__62 | T__63 | T__64 | T__65 | T__66 | T__67 | T__68 | T__69 | T__70 | T__71 | T__72 | T__73 | T__74 | T__75 | T__76 | T__77 | T__78 | T__79 | T__80 | T__81 | T__82 | T__83 | T__84 | T__85 | T__86 | NULL | BOOLEAN | ID | NUMBER | COMMENT | MULTILINE_STRING | NL | WS | STRING )
      alt_18 = 78
      alt_18 = @dfa18.predict( @input )
      case alt_18
      when 1
        # at line 1:10: T__18
        t__18!


      when 2
        # at line 1:16: T__19
        t__19!


      when 3
        # at line 1:22: T__20
        t__20!


      when 4
        # at line 1:28: T__21
        t__21!


      when 5
        # at line 1:34: T__22
        t__22!


      when 6
        # at line 1:40: T__23
        t__23!


      when 7
        # at line 1:46: T__24
        t__24!


      when 8
        # at line 1:52: T__25
        t__25!


      when 9
        # at line 1:58: T__26
        t__26!


      when 10
        # at line 1:64: T__27
        t__27!


      when 11
        # at line 1:70: T__28
        t__28!


      when 12
        # at line 1:76: T__29
        t__29!


      when 13
        # at line 1:82: T__30
        t__30!


      when 14
        # at line 1:88: T__31
        t__31!


      when 15
        # at line 1:94: T__32
        t__32!


      when 16
        # at line 1:100: T__33
        t__33!


      when 17
        # at line 1:106: T__34
        t__34!


      when 18
        # at line 1:112: T__35
        t__35!


      when 19
        # at line 1:118: T__36
        t__36!


      when 20
        # at line 1:124: T__37
        t__37!


      when 21
        # at line 1:130: T__38
        t__38!


      when 22
        # at line 1:136: T__39
        t__39!


      when 23
        # at line 1:142: T__40
        t__40!


      when 24
        # at line 1:148: T__41
        t__41!


      when 25
        # at line 1:154: T__42
        t__42!


      when 26
        # at line 1:160: T__43
        t__43!


      when 27
        # at line 1:166: T__44
        t__44!


      when 28
        # at line 1:172: T__45
        t__45!


      when 29
        # at line 1:178: T__46
        t__46!


      when 30
        # at line 1:184: T__47
        t__47!


      when 31
        # at line 1:190: T__48
        t__48!


      when 32
        # at line 1:196: T__49
        t__49!


      when 33
        # at line 1:202: T__50
        t__50!


      when 34
        # at line 1:208: T__51
        t__51!


      when 35
        # at line 1:214: T__52
        t__52!


      when 36
        # at line 1:220: T__53
        t__53!


      when 37
        # at line 1:226: T__54
        t__54!


      when 38
        # at line 1:232: T__55
        t__55!


      when 39
        # at line 1:238: T__56
        t__56!


      when 40
        # at line 1:244: T__57
        t__57!


      when 41
        # at line 1:250: T__58
        t__58!


      when 42
        # at line 1:256: T__59
        t__59!


      when 43
        # at line 1:262: T__60
        t__60!


      when 44
        # at line 1:268: T__61
        t__61!


      when 45
        # at line 1:274: T__62
        t__62!


      when 46
        # at line 1:280: T__63
        t__63!


      when 47
        # at line 1:286: T__64
        t__64!


      when 48
        # at line 1:292: T__65
        t__65!


      when 49
        # at line 1:298: T__66
        t__66!


      when 50
        # at line 1:304: T__67
        t__67!


      when 51
        # at line 1:310: T__68
        t__68!


      when 52
        # at line 1:316: T__69
        t__69!


      when 53
        # at line 1:322: T__70
        t__70!


      when 54
        # at line 1:328: T__71
        t__71!


      when 55
        # at line 1:334: T__72
        t__72!


      when 56
        # at line 1:340: T__73
        t__73!


      when 57
        # at line 1:346: T__74
        t__74!


      when 58
        # at line 1:352: T__75
        t__75!


      when 59
        # at line 1:358: T__76
        t__76!


      when 60
        # at line 1:364: T__77
        t__77!


      when 61
        # at line 1:370: T__78
        t__78!


      when 62
        # at line 1:376: T__79
        t__79!


      when 63
        # at line 1:382: T__80
        t__80!


      when 64
        # at line 1:388: T__81
        t__81!


      when 65
        # at line 1:394: T__82
        t__82!


      when 66
        # at line 1:400: T__83
        t__83!


      when 67
        # at line 1:406: T__84
        t__84!


      when 68
        # at line 1:412: T__85
        t__85!


      when 69
        # at line 1:418: T__86
        t__86!


      when 70
        # at line 1:424: NULL
        null!


      when 71
        # at line 1:429: BOOLEAN
        boolean!


      when 72
        # at line 1:437: ID
        id!


      when 73
        # at line 1:440: NUMBER
        number!


      when 74
        # at line 1:447: COMMENT
        comment!


      when 75
        # at line 1:455: MULTILINE_STRING
        multiline_string!


      when 76
        # at line 1:472: NL
        nl!


      when 77
        # at line 1:475: WS
        ws!


      when 78
        # at line 1:478: STRING
        string!


      end
    end


    # - - - - - - - - - - DFA definitions - - - - - - - - - - -
    class DFA18 < ANTLR3::DFA
      EOT = unpack( 1, -1, 1, 42, 8, -1, 1, 46, 1, 48, 1, -1, 1, 50, 2, 
                    -1, 16, 35, 2, -1, 1, 35, 16, -1, 6, 35, 1, 100, 13, 
                    35, 1, 116, 1, 118, 1, 123, 1, 35, 1, 126, 2, 35, 1, 
                    129, 1, 35, 1, 126, 2, 35, 1, -1, 14, 35, 1, 147, 1, 
                    35, 1, -1, 14, 35, 1, 166, 1, -1, 1, 35, 1, -1, 1, 168, 
                    3, 35, 1, -1, 1, 173, 1, 174, 1, -1, 1, 35, 1, 176, 
                    1, -1, 1, 126, 5, 35, 1, 182, 5, 35, 1, 126, 1, 35, 
                    1, -1, 2, 35, 1, -1, 5, 35, 1, 196, 11, 35, 1, 208, 
                    1, -1, 1, 35, 1, -1, 1, 35, 1, 211, 2, 35, 2, -1, 1, 
                    176, 1, -1, 5, 35, 1, -1, 1, 35, 1, 220, 1, 35, 1, 126, 
                    2, 35, 1, 224, 3, 35, 1, 228, 2, 35, 1, -1, 3, 35, 1, 
                    234, 1, 35, 1, 236, 3, 35, 1, 126, 1, 35, 1, -1, 1, 
                    35, 1, 242, 1, -1, 1, 243, 1, 244, 4, 35, 1, 249, 1, 
                    35, 1, -1, 3, 35, 1, -1, 1, 254, 1, 255, 1, 256, 1, 
                    -1, 2, 35, 1, 259, 1, 261, 1, 262, 1, -1, 1, 35, 1, 
                    -1, 1, 264, 2, 35, 1, 267, 1, 35, 3, -1, 2, 35, 1, 271, 
                    1, 35, 1, -1, 1, 35, 1, -1, 1, 274, 1, 35, 3, -1, 2, 
                    35, 1, -1, 1, 278, 2, -1, 1, 279, 1, -1, 1, 280, 1, 
                    281, 1, -1, 1, 282, 1, 35, 2, -1, 2, 35, 1, -1, 1, 286, 
                    2, 35, 5, -1, 1, 35, 1, 290, 1, 35, 1, -1, 1, 293, 1, 
                    35, 1, 295, 1, -1, 1, 35, 1, 297, 1, -1, 1, 298, 1, 
                    -1, 1, 35, 2, -1, 1, 35, 1, 301, 1, -1 )
      EOF = unpack( 302, -1 )
      MIN = unpack( 1, 9, 1, 61, 5, -1, 1, 48, 1, -1, 1, 42, 1, 100, 1, 
                    61, 1, -1, 1, 61, 2, -1, 1, 98, 1, 101, 1, 108, 1, 101, 
                    1, 102, 1, 97, 1, 108, 1, 97, 1, 102, 1, 101, 1, 102, 
                    1, 114, 1, 34, 1, 99, 1, 104, 1, 105, 2, -1, 1, 101, 
                    16, -1, 1, 115, 1, 100, 1, 116, 1, 119, 1, 121, 1, 101, 
                    1, 48, 1, 102, 1, 97, 1, 110, 1, 108, 1, 102, 1, 116, 
                    1, 105, 1, 110, 1, 114, 1, 108, 1, 111, 1, 97, 1, 115, 
                    3, 48, 1, 119, 1, 48, 2, 108, 1, 48, 1, 102, 1, 48, 
                    1, 111, 1, 109, 1, -1, 1, 104, 1, 109, 1, 97, 1, 98, 
                    1, 110, 1, 101, 1, 116, 1, 117, 1, 116, 1, 115, 1, 116, 
                    1, 40, 1, 101, 1, 97, 1, 48, 1, 97, 1, -1, 1, 111, 1, 
                    115, 1, 100, 1, 116, 2, 101, 1, 104, 1, 115, 1, 101, 
                    2, 97, 1, 115, 1, 98, 1, 108, 1, 48, 1, -1, 1, 108, 
                    1, -1, 1, 48, 1, 111, 2, 101, 1, -1, 2, 48, 1, -1, 1, 
                    108, 1, 48, 1, -1, 1, 48, 1, 99, 1, 111, 2, 101, 1, 
                    116, 1, 48, 1, 99, 1, 110, 1, 97, 1, 101, 1, 104, 1, 
                    48, 1, 114, 1, -1, 1, 114, 1, 121, 1, -1, 1, 108, 1, 
                    114, 1, 115, 1, 105, 1, 116, 1, 48, 1, 116, 1, 99, 1, 
                    101, 1, 116, 1, 110, 2, 108, 1, 97, 1, 111, 1, 101, 
                    1, 97, 1, 48, 1, -1, 1, 117, 1, -1, 1, 116, 1, 48, 1, 
                    102, 1, 116, 2, -1, 1, 48, 1, -1, 1, 101, 1, 118, 1, 
                    109, 1, 116, 1, 101, 1, -1, 1, 104, 1, 48, 1, 108, 1, 
                    48, 1, 105, 1, 97, 1, 48, 1, 115, 1, 108, 1, 101, 1, 
                    48, 1, 116, 1, 114, 1, -1, 1, 101, 1, 116, 1, 114, 1, 
                    48, 1, 100, 1, 48, 1, 108, 1, 99, 1, 109, 1, 48, 1, 
                    108, 1, -1, 1, 100, 1, 48, 1, -1, 2, 48, 1, 100, 1, 
                    101, 1, 97, 1, 105, 1, 48, 1, 114, 1, -1, 1, 40, 1, 
                    110, 1, 99, 1, -1, 3, 48, 1, -1, 1, 105, 1, 97, 3, 48, 
                    1, -1, 1, 115, 1, -1, 1, 48, 1, 104, 1, 101, 1, 48, 
                    1, 101, 3, -1, 1, 117, 1, 40, 1, 48, 1, 109, 1, -1, 
                    1, 111, 1, -1, 1, 48, 1, 116, 3, -1, 1, 111, 1, 105, 
                    1, -1, 1, 48, 2, -1, 1, 48, 1, -1, 2, 48, 1, -1, 1, 
                    48, 1, 114, 2, -1, 1, 101, 1, 110, 1, -1, 1, 48, 2, 
                    110, 5, -1, 1, 101, 1, 48, 1, 105, 1, -1, 1, 48, 1, 
                    116, 1, 48, 1, -1, 1, 122, 1, 48, 1, -1, 1, 48, 1, -1, 
                    1, 101, 2, -1, 1, 100, 1, 48, 1, -1 )
      MAX = unpack( 1, 125, 1, 61, 5, -1, 1, 61, 1, -1, 1, 61, 1, 100, 1, 
                    61, 1, -1, 1, 61, 2, -1, 1, 115, 1, 101, 1, 111, 1, 
                    101, 1, 120, 2, 111, 1, 97, 1, 115, 1, 117, 2, 114, 
                    1, 101, 1, 121, 1, 114, 1, 105, 2, -1, 1, 101, 16, -1, 
                    1, 115, 1, 100, 1, 116, 1, 119, 1, 121, 1, 101, 1, 122, 
                    1, 102, 1, 97, 1, 115, 1, 108, 1, 102, 2, 116, 1, 110, 
                    1, 114, 1, 108, 1, 111, 1, 97, 1, 115, 3, 122, 1, 119, 
                    1, 122, 2, 108, 1, 122, 1, 102, 1, 122, 1, 111, 1, 109, 
                    1, -1, 1, 104, 1, 109, 1, 97, 1, 98, 1, 110, 1, 101, 
                    1, 116, 1, 117, 1, 116, 1, 115, 1, 116, 1, 40, 1, 101, 
                    1, 97, 1, 122, 1, 97, 1, -1, 1, 111, 2, 115, 1, 116, 
                    2, 101, 1, 104, 1, 115, 1, 101, 1, 97, 2, 115, 1, 98, 
                    1, 108, 1, 122, 1, -1, 1, 108, 1, -1, 1, 122, 1, 116, 
                    2, 101, 1, -1, 2, 122, 1, -1, 1, 108, 1, 122, 1, -1, 
                    1, 122, 1, 99, 1, 111, 2, 101, 1, 116, 1, 122, 1, 99, 
                    1, 110, 1, 97, 1, 101, 1, 104, 1, 122, 1, 114, 1, -1, 
                    1, 114, 1, 121, 1, -1, 1, 108, 1, 114, 1, 115, 1, 105, 
                    1, 116, 1, 122, 1, 116, 1, 99, 1, 101, 1, 116, 1, 110, 
                    2, 108, 1, 97, 1, 111, 1, 101, 1, 97, 1, 122, 1, -1, 
                    1, 117, 1, -1, 1, 116, 1, 122, 1, 102, 1, 116, 2, -1, 
                    1, 122, 1, -1, 1, 101, 1, 118, 1, 109, 1, 116, 1, 101, 
                    1, -1, 1, 104, 1, 122, 1, 108, 1, 122, 1, 105, 1, 97, 
                    1, 122, 1, 115, 1, 108, 1, 101, 1, 122, 1, 116, 1, 114, 
                    1, -1, 1, 101, 1, 116, 1, 114, 1, 122, 1, 100, 1, 122, 
                    1, 108, 1, 99, 1, 109, 1, 122, 1, 108, 1, -1, 1, 100, 
                    1, 122, 1, -1, 2, 122, 1, 100, 1, 101, 1, 97, 1, 105, 
                    1, 122, 1, 114, 1, -1, 1, 40, 1, 110, 1, 99, 1, -1, 
                    3, 122, 1, -1, 1, 105, 1, 97, 3, 122, 1, -1, 1, 115, 
                    1, -1, 1, 122, 1, 104, 1, 101, 1, 122, 1, 101, 3, -1, 
                    1, 117, 1, 40, 1, 122, 1, 109, 1, -1, 1, 111, 1, -1, 
                    1, 122, 1, 116, 3, -1, 1, 111, 1, 105, 1, -1, 1, 122, 
                    2, -1, 1, 122, 1, -1, 2, 122, 1, -1, 1, 122, 1, 114, 
                    2, -1, 1, 101, 1, 110, 1, -1, 1, 122, 2, 110, 5, -1, 
                    1, 101, 1, 122, 1, 105, 1, -1, 1, 122, 1, 116, 1, 122, 
                    1, -1, 2, 122, 1, -1, 1, 122, 1, -1, 1, 101, 2, -1, 
                    1, 100, 1, 122, 1, -1 )
      ACCEPT = unpack( 2, -1, 1, 3, 1, 4, 1, 5, 1, 6, 1, 7, 1, -1, 1, 9, 
                       3, -1, 1, 15, 1, -1, 1, 18, 1, 19, 16, -1, 1, 68, 
                       1, 69, 1, -1, 1, 72, 1, 73, 1, 74, 1, 76, 1, 77, 
                       1, 78, 1, 2, 1, 1, 1, 8, 1, 10, 1, 12, 1, 11, 1, 
                       14, 1, 13, 1, 17, 1, 16, 32, -1, 1, 75, 16, -1, 1, 
                       26, 15, -1, 1, 46, 1, -1, 1, 47, 4, -1, 1, 49, 2, 
                       -1, 1, 71, 2, -1, 1, 57, 14, -1, 1, 21, 2, -1, 1, 
                       24, 18, -1, 1, 45, 1, -1, 1, 50, 4, -1, 1, 55, 1, 
                       56, 1, -1, 1, 70, 5, -1, 1, 63, 13, -1, 1, 32, 11, 
                       -1, 1, 44, 2, -1, 1, 52, 8, -1, 1, 65, 3, -1, 1, 
                       22, 3, -1, 1, 28, 5, -1, 1, 37, 1, -1, 1, 39, 5, 
                       -1, 1, 51, 1, 53, 1, 54, 4, -1, 1, 62, 1, -1, 1, 
                       66, 2, -1, 1, 23, 1, 25, 1, 27, 2, -1, 1, 33, 1, 
                       -1, 1, 34, 1, 36, 1, -1, 1, 40, 2, -1, 1, 43, 2, 
                       -1, 1, 59, 1, 60, 2, -1, 1, 67, 3, -1, 1, 35, 1, 
                       38, 1, 41, 1, 42, 1, 48, 3, -1, 1, 20, 3, -1, 1, 
                       61, 2, -1, 1, 29, 1, -1, 1, 58, 1, -1, 1, 30, 1, 
                       31, 2, -1, 1, 64 )
      SPECIAL = unpack( 302, -1 )
      TRANSITION = [
        unpack( 1, 39, 1, 38, 2, -1, 1, 38, 18, -1, 1, 39, 1, 1, 1, 40, 
                1, 37, 4, -1, 1, 2, 1, 3, 1, 4, 1, 5, 1, 6, 1, 7, 1, 8, 
                1, 9, 10, 36, 1, 10, 1, 38, 1, 11, 1, 12, 1, 13, 2, -1, 
                26, 35, 1, 14, 1, -1, 1, 15, 3, -1, 1, 16, 1, 17, 1, 18, 
                1, 19, 1, 20, 1, 21, 1, 22, 1, 23, 1, 24, 4, 35, 1, 25, 
                1, 26, 1, 27, 1, 35, 1, 28, 1, 29, 1, 30, 2, 35, 1, 31, 
                1, 35, 1, 34, 1, 35, 1, 32, 1, -1, 1, 33 ),
        unpack( 1, 41 ),
        unpack(  ),
        unpack(  ),
        unpack(  ),
        unpack(  ),
        unpack(  ),
        unpack( 10, 36, 3, -1, 1, 43 ),
        unpack(  ),
        unpack( 1, 37, 4, -1, 1, 37, 13, -1, 1, 44 ),
        unpack( 1, 45 ),
        unpack( 1, 47 ),
        unpack(  ),
        unpack( 1, 49 ),
        unpack(  ),
        unpack(  ),
        unpack( 1, 51, 1, -1, 1, 52, 1, -1, 1, 53, 5, -1, 1, 54, 1, -1, 
                 1, 55, 3, -1, 1, 56, 1, 57 ),
        unpack( 1, 58 ),
        unpack( 1, 59, 2, -1, 1, 60 ),
        unpack( 1, 61 ),
        unpack( 1, 62, 2, -1, 1, 63, 14, -1, 1, 64 ),
        unpack( 1, 67, 7, -1, 1, 65, 5, -1, 1, 66 ),
        unpack( 1, 68, 2, -1, 1, 69 ),
        unpack( 1, 70 ),
        unpack( 1, 71, 7, -1, 1, 72, 4, -1, 1, 73 ),
        unpack( 1, 74, 3, -1, 1, 77, 5, -1, 1, 75, 5, -1, 1, 76 ),
        unpack( 1, 79, 7, -1, 1, 80, 3, -1, 1, 78 ),
        unpack( 1, 81 ),
        unpack( 1, 83, 66, -1, 1, 82 ),
        unpack( 1, 84, 11, -1, 1, 85, 4, -1, 1, 86, 1, 87, 3, -1, 1, 88 ),
        unpack( 1, 89, 6, -1, 1, 90, 2, -1, 1, 91 ),
        unpack( 1, 92 ),
        unpack(  ),
        unpack(  ),
        unpack( 1, 93 ),
        unpack(  ),
        unpack(  ),
        unpack(  ),
        unpack(  ),
        unpack(  ),
        unpack(  ),
        unpack(  ),
        unpack(  ),
        unpack(  ),
        unpack(  ),
        unpack(  ),
        unpack(  ),
        unpack(  ),
        unpack(  ),
        unpack(  ),
        unpack(  ),
        unpack( 1, 94 ),
        unpack( 1, 95 ),
        unpack( 1, 96 ),
        unpack( 1, 97 ),
        unpack( 1, 98 ),
        unpack( 1, 99 ),
        unpack( 10, 35, 7, -1, 26, 35, 4, -1, 1, 35, 1, -1, 26, 35 ),
        unpack( 1, 101 ),
        unpack( 1, 102 ),
        unpack( 1, 103, 4, -1, 1, 104 ),
        unpack( 1, 105 ),
        unpack( 1, 106 ),
        unpack( 1, 107 ),
        unpack( 1, 108, 10, -1, 1, 109 ),
        unpack( 1, 110 ),
        unpack( 1, 111 ),
        unpack( 1, 112 ),
        unpack( 1, 113 ),
        unpack( 1, 114 ),
        unpack( 1, 115 ),
        unpack( 10, 35, 7, -1, 26, 35, 4, -1, 1, 35, 1, -1, 26, 35 ),
        unpack( 10, 35, 7, -1, 26, 35, 4, -1, 1, 35, 1, -1, 2, 35, 1, 117, 
                 23, 35 ),
        unpack( 10, 35, 7, -1, 26, 35, 4, -1, 1, 35, 1, -1, 1, 119, 12, 
                 35, 1, 120, 3, 35, 1, 121, 1, 122, 7, 35 ),
        unpack( 1, 124 ),
        unpack( 10, 35, 7, -1, 26, 35, 4, -1, 1, 35, 1, -1, 19, 35, 1, 
                 125, 6, 35 ),
        unpack( 1, 127 ),
        unpack( 1, 128 ),
        unpack( 10, 35, 7, -1, 26, 35, 4, -1, 1, 35, 1, -1, 26, 35 ),
        unpack( 1, 130 ),
        unpack( 10, 35, 7, -1, 26, 35, 4, -1, 1, 35, 1, -1, 26, 35 ),
        unpack( 1, 131 ),
        unpack( 1, 132 ),
        unpack(  ),
        unpack( 1, 133 ),
        unpack( 1, 134 ),
        unpack( 1, 135 ),
        unpack( 1, 136 ),
        unpack( 1, 137 ),
        unpack( 1, 138 ),
        unpack( 1, 139 ),
        unpack( 1, 140 ),
        unpack( 1, 141 ),
        unpack( 1, 142 ),
        unpack( 1, 143 ),
        unpack( 1, 144 ),
        unpack( 1, 145 ),
        unpack( 1, 146 ),
        unpack( 10, 35, 7, -1, 26, 35, 4, -1, 1, 35, 1, -1, 26, 35 ),
        unpack( 1, 148 ),
        unpack(  ),
        unpack( 1, 149 ),
        unpack( 1, 150 ),
        unpack( 1, 151, 14, -1, 1, 152 ),
        unpack( 1, 153 ),
        unpack( 1, 154 ),
        unpack( 1, 155 ),
        unpack( 1, 156 ),
        unpack( 1, 157 ),
        unpack( 1, 158 ),
        unpack( 1, 159 ),
        unpack( 1, 160, 3, -1, 1, 161, 13, -1, 1, 162 ),
        unpack( 1, 163 ),
        unpack( 1, 164 ),
        unpack( 1, 165 ),
        unpack( 10, 35, 7, -1, 26, 35, 4, -1, 1, 35, 1, -1, 26, 35 ),
        unpack(  ),
        unpack( 1, 167 ),
        unpack(  ),
        unpack( 10, 35, 7, -1, 26, 35, 4, -1, 1, 35, 1, -1, 26, 35 ),
        unpack( 1, 169, 4, -1, 1, 170 ),
        unpack( 1, 171 ),
        unpack( 1, 172 ),
        unpack(  ),
        unpack( 10, 35, 7, -1, 26, 35, 4, -1, 1, 35, 1, -1, 26, 35 ),
        unpack( 10, 35, 7, -1, 26, 35, 4, -1, 1, 35, 1, -1, 26, 35 ),
        unpack(  ),
        unpack( 1, 175 ),
        unpack( 10, 35, 7, -1, 26, 35, 4, -1, 1, 35, 1, -1, 26, 35 ),
        unpack(  ),
        unpack( 10, 35, 7, -1, 26, 35, 4, -1, 1, 35, 1, -1, 26, 35 ),
        unpack( 1, 177 ),
        unpack( 1, 178 ),
        unpack( 1, 179 ),
        unpack( 1, 180 ),
        unpack( 1, 181 ),
        unpack( 10, 35, 7, -1, 26, 35, 4, -1, 1, 35, 1, -1, 26, 35 ),
        unpack( 1, 183 ),
        unpack( 1, 184 ),
        unpack( 1, 185 ),
        unpack( 1, 186 ),
        unpack( 1, 187 ),
        unpack( 10, 35, 7, -1, 26, 35, 4, -1, 1, 35, 1, -1, 26, 35 ),
        unpack( 1, 188 ),
        unpack(  ),
        unpack( 1, 189 ),
        unpack( 1, 190 ),
        unpack(  ),
        unpack( 1, 191 ),
        unpack( 1, 192 ),
        unpack( 1, 193 ),
        unpack( 1, 194 ),
        unpack( 1, 195 ),
        unpack( 10, 35, 7, -1, 26, 35, 4, -1, 1, 35, 1, -1, 26, 35 ),
        unpack( 1, 197 ),
        unpack( 1, 198 ),
        unpack( 1, 199 ),
        unpack( 1, 200 ),
        unpack( 1, 201 ),
        unpack( 1, 202 ),
        unpack( 1, 203 ),
        unpack( 1, 204 ),
        unpack( 1, 205 ),
        unpack( 1, 206 ),
        unpack( 1, 207 ),
        unpack( 10, 35, 7, -1, 26, 35, 4, -1, 1, 35, 1, -1, 26, 35 ),
        unpack(  ),
        unpack( 1, 209 ),
        unpack(  ),
        unpack( 1, 210 ),
        unpack( 10, 35, 7, -1, 26, 35, 4, -1, 1, 35, 1, -1, 26, 35 ),
        unpack( 1, 212 ),
        unpack( 1, 213 ),
        unpack(  ),
        unpack(  ),
        unpack( 10, 35, 7, -1, 26, 35, 4, -1, 1, 35, 1, -1, 26, 35 ),
        unpack(  ),
        unpack( 1, 214 ),
        unpack( 1, 215 ),
        unpack( 1, 216 ),
        unpack( 1, 217 ),
        unpack( 1, 218 ),
        unpack(  ),
        unpack( 1, 219 ),
        unpack( 10, 35, 7, -1, 26, 35, 4, -1, 1, 35, 1, -1, 26, 35 ),
        unpack( 1, 221 ),
        unpack( 10, 35, 7, -1, 26, 35, 4, -1, 1, 35, 1, -1, 26, 35 ),
        unpack( 1, 222 ),
        unpack( 1, 223 ),
        unpack( 10, 35, 7, -1, 26, 35, 4, -1, 1, 35, 1, -1, 26, 35 ),
        unpack( 1, 225 ),
        unpack( 1, 226 ),
        unpack( 1, 227 ),
        unpack( 10, 35, 7, -1, 26, 35, 4, -1, 1, 35, 1, -1, 26, 35 ),
        unpack( 1, 229 ),
        unpack( 1, 230 ),
        unpack(  ),
        unpack( 1, 231 ),
        unpack( 1, 232 ),
        unpack( 1, 233 ),
        unpack( 10, 35, 7, -1, 26, 35, 4, -1, 1, 35, 1, -1, 26, 35 ),
        unpack( 1, 235 ),
        unpack( 10, 35, 7, -1, 26, 35, 4, -1, 1, 35, 1, -1, 26, 35 ),
        unpack( 1, 237 ),
        unpack( 1, 238 ),
        unpack( 1, 239 ),
        unpack( 10, 35, 7, -1, 26, 35, 4, -1, 1, 35, 1, -1, 26, 35 ),
        unpack( 1, 240 ),
        unpack(  ),
        unpack( 1, 241 ),
        unpack( 10, 35, 7, -1, 26, 35, 4, -1, 1, 35, 1, -1, 26, 35 ),
        unpack(  ),
        unpack( 10, 35, 7, -1, 26, 35, 4, -1, 1, 35, 1, -1, 26, 35 ),
        unpack( 10, 35, 7, -1, 26, 35, 4, -1, 1, 35, 1, -1, 26, 35 ),
        unpack( 1, 245 ),
        unpack( 1, 246 ),
        unpack( 1, 247 ),
        unpack( 1, 248 ),
        unpack( 10, 35, 7, -1, 26, 35, 4, -1, 1, 35, 1, -1, 26, 35 ),
        unpack( 1, 250 ),
        unpack(  ),
        unpack( 1, 251 ),
        unpack( 1, 252 ),
        unpack( 1, 253 ),
        unpack(  ),
        unpack( 10, 35, 7, -1, 26, 35, 4, -1, 1, 35, 1, -1, 26, 35 ),
        unpack( 10, 35, 7, -1, 26, 35, 4, -1, 1, 35, 1, -1, 26, 35 ),
        unpack( 10, 35, 7, -1, 26, 35, 4, -1, 1, 35, 1, -1, 26, 35 ),
        unpack(  ),
        unpack( 1, 257 ),
        unpack( 1, 258 ),
        unpack( 10, 35, 7, -1, 26, 35, 4, -1, 1, 35, 1, -1, 26, 35 ),
        unpack( 10, 35, 7, -1, 26, 35, 4, -1, 1, 35, 1, -1, 18, 35, 1, 
                 260, 7, 35 ),
        unpack( 10, 35, 7, -1, 26, 35, 4, -1, 1, 35, 1, -1, 26, 35 ),
        unpack(  ),
        unpack( 1, 263 ),
        unpack(  ),
        unpack( 10, 35, 7, -1, 26, 35, 4, -1, 1, 35, 1, -1, 26, 35 ),
        unpack( 1, 265 ),
        unpack( 1, 266 ),
        unpack( 10, 35, 7, -1, 26, 35, 4, -1, 1, 35, 1, -1, 26, 35 ),
        unpack( 1, 268 ),
        unpack(  ),
        unpack(  ),
        unpack(  ),
        unpack( 1, 269 ),
        unpack( 1, 270 ),
        unpack( 10, 35, 7, -1, 26, 35, 4, -1, 1, 35, 1, -1, 26, 35 ),
        unpack( 1, 272 ),
        unpack(  ),
        unpack( 1, 273 ),
        unpack(  ),
        unpack( 10, 35, 7, -1, 26, 35, 4, -1, 1, 35, 1, -1, 26, 35 ),
        unpack( 1, 275 ),
        unpack(  ),
        unpack(  ),
        unpack(  ),
        unpack( 1, 276 ),
        unpack( 1, 277 ),
        unpack(  ),
        unpack( 10, 35, 7, -1, 26, 35, 4, -1, 1, 35, 1, -1, 26, 35 ),
        unpack(  ),
        unpack(  ),
        unpack( 10, 35, 7, -1, 26, 35, 4, -1, 1, 35, 1, -1, 26, 35 ),
        unpack(  ),
        unpack( 10, 35, 7, -1, 26, 35, 4, -1, 1, 35, 1, -1, 26, 35 ),
        unpack( 10, 35, 7, -1, 26, 35, 4, -1, 1, 35, 1, -1, 26, 35 ),
        unpack(  ),
        unpack( 10, 35, 7, -1, 26, 35, 4, -1, 1, 35, 1, -1, 26, 35 ),
        unpack( 1, 283 ),
        unpack(  ),
        unpack(  ),
        unpack( 1, 284 ),
        unpack( 1, 285 ),
        unpack(  ),
        unpack( 10, 35, 7, -1, 26, 35, 4, -1, 1, 35, 1, -1, 26, 35 ),
        unpack( 1, 287 ),
        unpack( 1, 288 ),
        unpack(  ),
        unpack(  ),
        unpack(  ),
        unpack(  ),
        unpack(  ),
        unpack( 1, 289 ),
        unpack( 10, 35, 7, -1, 26, 35, 4, -1, 1, 35, 1, -1, 26, 35 ),
        unpack( 1, 291 ),
        unpack(  ),
        unpack( 10, 35, 7, -1, 26, 35, 4, -1, 1, 35, 1, -1, 18, 35, 1, 
                 292, 7, 35 ),
        unpack( 1, 294 ),
        unpack( 10, 35, 7, -1, 26, 35, 4, -1, 1, 35, 1, -1, 26, 35 ),
        unpack(  ),
        unpack( 1, 296 ),
        unpack( 10, 35, 7, -1, 26, 35, 4, -1, 1, 35, 1, -1, 26, 35 ),
        unpack(  ),
        unpack( 10, 35, 7, -1, 26, 35, 4, -1, 1, 35, 1, -1, 26, 35 ),
        unpack(  ),
        unpack( 1, 299 ),
        unpack(  ),
        unpack(  ),
        unpack( 1, 300 ),
        unpack( 10, 35, 7, -1, 26, 35, 4, -1, 1, 35, 1, -1, 26, 35 ),
        unpack(  )
      ].freeze

      ( 0 ... MIN.length ).zip( MIN, MAX ) do | i, a, z |
        if a > 0 and z < 0
          MAX[ i ] %= 0x10000
        end
      end

      @decision = 18


      def description
        <<-'__dfa_description__'.strip!
          1:1: Tokens : ( T__18 | T__19 | T__20 | T__21 | T__22 | T__23 | T__24 | T__25 | T__26 | T__27 | T__28 | T__29 | T__30 | T__31 | T__32 | T__33 | T__34 | T__35 | T__36 | T__37 | T__38 | T__39 | T__40 | T__41 | T__42 | T__43 | T__44 | T__45 | T__46 | T__47 | T__48 | T__49 | T__50 | T__51 | T__52 | T__53 | T__54 | T__55 | T__56 | T__57 | T__58 | T__59 | T__60 | T__61 | T__62 | T__63 | T__64 | T__65 | T__66 | T__67 | T__68 | T__69 | T__70 | T__71 | T__72 | T__73 | T__74 | T__75 | T__76 | T__77 | T__78 | T__79 | T__80 | T__81 | T__82 | T__83 | T__84 | T__85 | T__86 | NULL | BOOLEAN | ID | NUMBER | COMMENT | MULTILINE_STRING | NL | WS | STRING );
        __dfa_description__
      end

    end


    private

    def initialize_dfas
      super rescue nil
      @dfa18 = DFA18.new( self, 18 )


    end

  end # class Lexer < ANTLR3::Lexer

  at_exit { Lexer.main( ARGV ) } if __FILE__ == $0

end
