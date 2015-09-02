#!/usr/bin/env ruby
#
# SfpLang.g
# --
# Generated using ANTLR version: 3.5
# Ruby runtime library version: 1.10.0
# Input grammar file: SfpLang.g
# Generated at: 2014-04-04 10:32:34
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


    # register the proper human-readable name or literal value
    # for each token type
    #
    # this is necessary because anonymous tokens, which are
    # created from literal values in the grammar, do not
    # have descriptive names
    register_names( "BOOLEAN", "COMMENT", "ESC_SEQ", "EXPONENT", "HEX_DIGIT", 
                    "ID", "MULTILINE_STRING", "NL", "NULL", "NUMBER", "OCTAL_ESC", 
                    "STRING", "UNICODE_ESC", "WS", "'!'", "'!='", "'('", 
                    "')'", "'*='", "'+='", "','", "'-='", "'.'", "'/='", 
                    "':'", "':different'", "'<'", "'<='", "'='", "'>'", 
                    "'>='", "'['", "']'", "'abstract'", "'add('", "'after'", 
                    "'always'", "'any'", "'areall'", "'as'", "'before'", 
                    "'class'", "'condition'", "'conditions'", "'constraint'", 
                    "'cost'", "'delete'", "'effect'", "'effects'", "'either'", 
                    "'exist'", "'extends'", "'final'", "'forall'", "'foreach'", 
                    "'forsome'", "'global'", "'goal'", "'has'", "'if'", 
                    "'in'", "'include'", "'is'", "'isa'", "'isnot'", "'isnt'", 
                    "'isref'", "'isset'", "'new'", "'not'", "'or'", "'procedure'", 
                    "'remove('", "'schema'", "'sometime'", "'state'", "'sub'", 
                    "'synchronized'", "'then'", "'total('", "'within'", 
                    "'{'", "'}'" )


  end


  class Parser < ANTLR3::Parser
    @grammar_home = SfpLang
    include ANTLR3::ASTBuilder

    RULE_METHODS = [ :sfp, :placement, :constraint_def, :include, :include_file, 
                     :state, :class_def, :extends_class, :attribute, :assignment, 
                     :object_schema, :object_schemata, :abstract_object, 
                     :object_def, :object_body, :object_attribute, :state_dependency, 
                     :dep_effect, :op_param, :op_conditions, :op_effects, 
                     :op_statement, :procedure, :parameters, :parameter, 
                     :conditions, :effects, :goal_constraint, :global_constraint, 
                     :sometime_constraint, :goal_body, :nested_constraint, 
                     :constraint, :constraint_body, :constraint_namespace, 
                     :constraint_iterator, :quantification_keyword, :constraint_class_quantification, 
                     :constraint_different, :constraint_statement, :total_constraint, 
                     :total_statement, :comp_value, :conditional_constraint, 
                     :conditional_constraint_if_part, :conditional_constraint_then_part, 
                     :effect_body, :mutation_iterator, :mutation, :set_value, 
                     :set_item, :value, :primitive_value, :path, :path_with_index, 
                     :id_ref, :reference, :reference_type, :set_type, :probability_op, 
                     :equals_op, :not_equals_op, :binary_op, :binary_comp ].freeze

    include TokenData

    begin
      generated_using( "SfpLang.g", "3.5", "1.10.0" )
    rescue NoMethodError => error
      # ignore
    end

    def initialize( input, options = {} )
      super( input, options )
    end

    	include Sfp::SfpLangHelper

    # - - - - - - - - - - - - Rules - - - - - - - - - - - - -
    SfpReturnValue = define_return_scope

    #
    # parser rule sfp
    #
    # (in SfpLang.g)
    # 39:1: sfp : ( NL )* ( ( object_def | abstract_object | state | constraint_def | class_def | procedure ) ( NL )* | include | placement )* ;
    #
    def sfp
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 1 )


      return_value = SfpReturnValue.new

      # $rule.start = the first token seen before matching
      return_value.start = @input.look


      root_0 = nil

      __NL1__ = nil
      __NL8__ = nil
      object_def2 = nil
      abstract_object3 = nil
      state4 = nil
      constraint_def5 = nil
      class_def6 = nil
      procedure7 = nil
      include9 = nil
      placement10 = nil


      tree_for_NL1 = nil
      tree_for_NL8 = nil

      begin
      root_0 = @adaptor.create_flat_list


      # at line 40:4: ( NL )* ( ( object_def | abstract_object | state | constraint_def | class_def | procedure ) ( NL )* | include | placement )*
      # --> action
       self.init 
      # <-- action

      # at line 41:3: ( NL )*
      while true # decision 1
        alt_1 = 2
        look_1_0 = @input.peek( 1 )

        if ( look_1_0 == NL )
          alt_1 = 1

        end
        case alt_1
        when 1
          # at line 41:3: NL
          __NL1__ = match( NL, TOKENS_FOLLOWING_NL_IN_sfp_49 )
          tree_for_NL1 = @adaptor.create_with_payload( __NL1__ )
          @adaptor.add_child( root_0, tree_for_NL1 )



        else
          break # out of loop for decision 1
        end
      end # loop for decision 1

      # at line 42:3: ( ( object_def | abstract_object | state | constraint_def | class_def | procedure ) ( NL )* | include | placement )*
      while true # decision 4
        alt_4 = 4
        case look_4 = @input.peek( 1 )
        when ID, T__37, T__40, T__45, T__60, T__61, T__75, T__77, T__78, T__80, T__81 then alt_4 = 1
        when T__65 then alt_4 = 2
        when T__18 then alt_4 = 3
        end
        case alt_4
        when 1
          # at line 42:5: ( object_def | abstract_object | state | constraint_def | class_def | procedure ) ( NL )*
          # at line 42:5: ( object_def | abstract_object | state | constraint_def | class_def | procedure )
          alt_2 = 6
          case look_2 = @input.peek( 1 )
          when ID then look_2_1 = @input.peek( 2 )

          if ( look_2_1 == T__79 )
            alt_2 = 3
          elsif ( look_2_1 == EOF || look_2_1 == ID || look_2_1 == NL || look_2_1 == T__18 || look_2_1 == T__37 || look_2_1 == T__40 || look_2_1 == T__45 || look_2_1 == T__55 || look_2_1.between?( T__60, T__61 ) || look_2_1 == T__65 || look_2_1 == T__67 || look_2_1 == T__75 || look_2_1.between?( T__77, T__78 ) || look_2_1.between?( T__80, T__81 ) || look_2_1 == T__85 )
            alt_2 = 1
          else
            raise NoViableAlternative( "", 2, 1 )

          end
          when T__37 then alt_2 = 2
          when T__40, T__60, T__61, T__78 then alt_2 = 4
          when T__45, T__77 then alt_2 = 5
          when T__75, T__80, T__81 then alt_2 = 6
          else
            raise NoViableAlternative( "", 2, 0 )

          end
          case alt_2
          when 1
            # at line 42:6: object_def
            @state.following.push( TOKENS_FOLLOWING_object_def_IN_sfp_57 )
            object_def2 = object_def
            @state.following.pop
            @adaptor.add_child( root_0, object_def2.tree )


          when 2
            # at line 42:19: abstract_object
            @state.following.push( TOKENS_FOLLOWING_abstract_object_IN_sfp_61 )
            abstract_object3 = abstract_object
            @state.following.pop
            @adaptor.add_child( root_0, abstract_object3.tree )


          when 3
            # at line 42:37: state
            @state.following.push( TOKENS_FOLLOWING_state_IN_sfp_65 )
            state4 = state
            @state.following.pop
            @adaptor.add_child( root_0, state4.tree )


          when 4
            # at line 42:45: constraint_def
            @state.following.push( TOKENS_FOLLOWING_constraint_def_IN_sfp_69 )
            constraint_def5 = constraint_def
            @state.following.pop
            @adaptor.add_child( root_0, constraint_def5.tree )


          when 5
            # at line 42:62: class_def
            @state.following.push( TOKENS_FOLLOWING_class_def_IN_sfp_73 )
            class_def6 = class_def
            @state.following.pop
            @adaptor.add_child( root_0, class_def6.tree )


          when 6
            # at line 42:74: procedure
            @state.following.push( TOKENS_FOLLOWING_procedure_IN_sfp_77 )
            procedure7 = procedure
            @state.following.pop
            @adaptor.add_child( root_0, procedure7.tree )


          end
          # at line 42:85: ( NL )*
          while true # decision 3
            alt_3 = 2
            look_3_0 = @input.peek( 1 )

            if ( look_3_0 == NL )
              alt_3 = 1

            end
            case alt_3
            when 1
              # at line 42:85: NL
              __NL8__ = match( NL, TOKENS_FOLLOWING_NL_IN_sfp_80 )
              tree_for_NL8 = @adaptor.create_with_payload( __NL8__ )
              @adaptor.add_child( root_0, tree_for_NL8 )



            else
              break # out of loop for decision 3
            end
          end # loop for decision 3


        when 2
          # at line 43:5: include
          @state.following.push( TOKENS_FOLLOWING_include_IN_sfp_87 )
          include9 = include
          @state.following.pop
          @adaptor.add_child( root_0, include9.tree )


        when 3
          # at line 44:5: placement
          @state.following.push( TOKENS_FOLLOWING_placement_IN_sfp_93 )
          placement10 = placement
          @state.following.pop
          @adaptor.add_child( root_0, placement10.tree )


        else
          break # out of loop for decision 4
        end
      end # loop for decision 4


      # --> action
       self.finalize 
      # <-- action


      # - - - - - - - rule clean up - - - - - - - -
      return_value.stop = @input.look( -1 )


      return_value.tree = @adaptor.rule_post_processing( root_0 )
      @adaptor.set_token_boundaries( return_value.tree, return_value.start, return_value.stop )


      rescue ANTLR3::Error::RecognitionError => re
        report_error(re)
        recover(re)
        return_value.tree = @adaptor.create_error_node( @input, return_value.start, @input.look(-1), re )


      ensure
        # -> uncomment the next line to manually enable rule tracing
        # trace_out( __method__, 1 )


      end

      return return_value
    end

    PlacementReturnValue = define_return_scope

    #
    # parser rule placement
    #
    # (in SfpLang.g)
    # 49:1: placement : '!' path assignment[id] ;
    #
    def placement
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 2 )


      return_value = PlacementReturnValue.new

      # $rule.start = the first token seen before matching
      return_value.start = @input.look


      root_0 = nil

      char_literal11 = nil
      path12 = nil
      assignment13 = nil


      tree_for_char_literal11 = nil

      begin
      root_0 = @adaptor.create_flat_list


      # at line 50:4: '!' path assignment[id]
      char_literal11 = match( T__18, TOKENS_FOLLOWING_T__18_IN_placement_113 )
      tree_for_char_literal11 = @adaptor.create_with_payload( char_literal11 )
      @adaptor.add_child( root_0, tree_for_char_literal11 )


      @state.following.push( TOKENS_FOLLOWING_path_IN_placement_115 )
      path12 = path
      @state.following.pop
      @adaptor.add_child( root_0, path12.tree )


      # --> action

      			ref = "$.#{( path12 && @input.to_s( path12.start, path12.stop ) )}"
      			parent, id = ref.pop_ref
      			@now = @root.at?(parent)
      			fail "parent #{parent} is not exist" if not @now.is_a?(Hash)
      		
      # <-- action

      @state.following.push( TOKENS_FOLLOWING_assignment_IN_placement_123 )
      assignment13 = assignment( id )
      @state.following.pop
      @adaptor.add_child( root_0, assignment13.tree )


      # --> action

      			@now = @root
      		
      # <-- action


      # - - - - - - - rule clean up - - - - - - - -
      return_value.stop = @input.look( -1 )


      return_value.tree = @adaptor.rule_post_processing( root_0 )
      @adaptor.set_token_boundaries( return_value.tree, return_value.start, return_value.stop )


      rescue ANTLR3::Error::RecognitionError => re
        report_error(re)
        recover(re)
        return_value.tree = @adaptor.create_error_node( @input, return_value.start, @input.look(-1), re )


      ensure
        # -> uncomment the next line to manually enable rule tracing
        # trace_out( __method__, 2 )


      end

      return return_value
    end

    ConstraintDefReturnValue = define_return_scope

    #
    # parser rule constraint_def
    #
    # (in SfpLang.g)
    # 63:1: constraint_def : ( goal_constraint | global_constraint | sometime_constraint );
    #
    def constraint_def
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 3 )


      return_value = ConstraintDefReturnValue.new

      # $rule.start = the first token seen before matching
      return_value.start = @input.look


      root_0 = nil

      goal_constraint14 = nil
      global_constraint15 = nil
      sometime_constraint16 = nil



      begin
      # at line 64:2: ( goal_constraint | global_constraint | sometime_constraint )
      alt_5 = 3
      case look_5 = @input.peek( 1 )
      when T__61 then alt_5 = 1
      when T__40, T__60 then alt_5 = 2
      when T__78 then alt_5 = 3
      else
        raise NoViableAlternative( "", 5, 0 )

      end
      case alt_5
      when 1
        root_0 = @adaptor.create_flat_list


        # at line 64:4: goal_constraint
        @state.following.push( TOKENS_FOLLOWING_goal_constraint_IN_constraint_def_139 )
        goal_constraint14 = goal_constraint
        @state.following.pop
        @adaptor.add_child( root_0, goal_constraint14.tree )


      when 2
        root_0 = @adaptor.create_flat_list


        # at line 65:4: global_constraint
        @state.following.push( TOKENS_FOLLOWING_global_constraint_IN_constraint_def_144 )
        global_constraint15 = global_constraint
        @state.following.pop
        @adaptor.add_child( root_0, global_constraint15.tree )


      when 3
        root_0 = @adaptor.create_flat_list


        # at line 66:4: sometime_constraint
        @state.following.push( TOKENS_FOLLOWING_sometime_constraint_IN_constraint_def_149 )
        sometime_constraint16 = sometime_constraint
        @state.following.pop
        @adaptor.add_child( root_0, sometime_constraint16.tree )


      end
      # - - - - - - - rule clean up - - - - - - - -
      return_value.stop = @input.look( -1 )


      return_value.tree = @adaptor.rule_post_processing( root_0 )
      @adaptor.set_token_boundaries( return_value.tree, return_value.start, return_value.stop )


      rescue ANTLR3::Error::RecognitionError => re
        report_error(re)
        recover(re)
        return_value.tree = @adaptor.create_error_node( @input, return_value.start, @input.look(-1), re )


      ensure
        # -> uncomment the next line to manually enable rule tracing
        # trace_out( __method__, 3 )


      end

      return return_value
    end

    IncludeReturnValue = define_return_scope

    #
    # parser rule include
    #
    # (in SfpLang.g)
    # 69:1: include : 'include' include_file ( NL )+ ;
    #
    def include
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 4 )


      return_value = IncludeReturnValue.new

      # $rule.start = the first token seen before matching
      return_value.start = @input.look


      root_0 = nil

      string_literal17 = nil
      __NL19__ = nil
      include_file18 = nil


      tree_for_string_literal17 = nil
      tree_for_NL19 = nil

      begin
      root_0 = @adaptor.create_flat_list


      # at line 70:4: 'include' include_file ( NL )+
      string_literal17 = match( T__65, TOKENS_FOLLOWING_T__65_IN_include_160 )
      tree_for_string_literal17 = @adaptor.create_with_payload( string_literal17 )
      @adaptor.add_child( root_0, tree_for_string_literal17 )


      @state.following.push( TOKENS_FOLLOWING_include_file_IN_include_162 )
      include_file18 = include_file
      @state.following.pop
      @adaptor.add_child( root_0, include_file18.tree )

      # at file 70:27: ( NL )+
      match_count_6 = 0
      while true
        alt_6 = 2
        look_6_0 = @input.peek( 1 )

        if ( look_6_0 == NL )
          alt_6 = 1

        end
        case alt_6
        when 1
          # at line 70:27: NL
          __NL19__ = match( NL, TOKENS_FOLLOWING_NL_IN_include_164 )
          tree_for_NL19 = @adaptor.create_with_payload( __NL19__ )
          @adaptor.add_child( root_0, tree_for_NL19 )



        else
          match_count_6 > 0 and break
          eee = EarlyExit(6)


          raise eee
        end
        match_count_6 += 1
      end



      # - - - - - - - rule clean up - - - - - - - -
      return_value.stop = @input.look( -1 )


      return_value.tree = @adaptor.rule_post_processing( root_0 )
      @adaptor.set_token_boundaries( return_value.tree, return_value.start, return_value.stop )


      rescue ANTLR3::Error::RecognitionError => re
        report_error(re)
        recover(re)
        return_value.tree = @adaptor.create_error_node( @input, return_value.start, @input.look(-1), re )


      ensure
        # -> uncomment the next line to manually enable rule tracing
        # trace_out( __method__, 4 )


      end

      return return_value
    end

    IncludeFileReturnValue = define_return_scope

    #
    # parser rule include_file
    #
    # (in SfpLang.g)
    # 73:1: include_file : STRING ;
    #
    def include_file
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 5 )


      return_value = IncludeFileReturnValue.new

      # $rule.start = the first token seen before matching
      return_value.start = @input.look


      root_0 = nil

      __STRING20__ = nil


      tree_for_STRING20 = nil

      begin
      root_0 = @adaptor.create_flat_list


      # at line 74:4: STRING
      __STRING20__ = match( STRING, TOKENS_FOLLOWING_STRING_IN_include_file_176 )
      tree_for_STRING20 = @adaptor.create_with_payload( __STRING20__ )
      @adaptor.add_child( root_0, tree_for_STRING20 )



      # --> action
       self.process_file(__STRING20__.text[1,__STRING20__.text.length-2]) 
      # <-- action


      # - - - - - - - rule clean up - - - - - - - -
      return_value.stop = @input.look( -1 )


      return_value.tree = @adaptor.rule_post_processing( root_0 )
      @adaptor.set_token_boundaries( return_value.tree, return_value.start, return_value.stop )


      rescue ANTLR3::Error::RecognitionError => re
        report_error(re)
        recover(re)
        return_value.tree = @adaptor.create_error_node( @input, return_value.start, @input.look(-1), re )


      ensure
        # -> uncomment the next line to manually enable rule tracing
        # trace_out( __method__, 5 )


      end

      return return_value
    end

    StateReturnValue = define_return_scope

    #
    # parser rule state
    #
    # (in SfpLang.g)
    # 78:1: state : ID 'state' ( NL )* '{' ( NL )* ( attribute )* '}' ;
    #
    def state
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 6 )


      return_value = StateReturnValue.new

      # $rule.start = the first token seen before matching
      return_value.start = @input.look


      root_0 = nil

      __ID21__ = nil
      string_literal22 = nil
      __NL23__ = nil
      char_literal24 = nil
      __NL25__ = nil
      char_literal27 = nil
      attribute26 = nil


      tree_for_ID21 = nil
      tree_for_string_literal22 = nil
      tree_for_NL23 = nil
      tree_for_char_literal24 = nil
      tree_for_NL25 = nil
      tree_for_char_literal27 = nil

      begin
      root_0 = @adaptor.create_flat_list


      # at line 79:4: ID 'state' ( NL )* '{' ( NL )* ( attribute )* '}'
      __ID21__ = match( ID, TOKENS_FOLLOWING_ID_IN_state_192 )
      tree_for_ID21 = @adaptor.create_with_payload( __ID21__ )
      @adaptor.add_child( root_0, tree_for_ID21 )


      string_literal22 = match( T__79, TOKENS_FOLLOWING_T__79_IN_state_194 )
      tree_for_string_literal22 = @adaptor.create_with_payload( string_literal22 )
      @adaptor.add_child( root_0, tree_for_string_literal22 )


      # at line 79:15: ( NL )*
      while true # decision 7
        alt_7 = 2
        look_7_0 = @input.peek( 1 )

        if ( look_7_0 == NL )
          alt_7 = 1

        end
        case alt_7
        when 1
          # at line 79:15: NL
          __NL23__ = match( NL, TOKENS_FOLLOWING_NL_IN_state_196 )
          tree_for_NL23 = @adaptor.create_with_payload( __NL23__ )
          @adaptor.add_child( root_0, tree_for_NL23 )



        else
          break # out of loop for decision 7
        end
      end # loop for decision 7


      # --> action

      			@now[__ID21__.text] = { '_self' => __ID21__.text,
      				'_context' => 'state',
      				'_parent' => @now
      			}
      			@now = @now[__ID21__.text]
      		
      # <-- action

      char_literal24 = match( T__85, TOKENS_FOLLOWING_T__85_IN_state_205 )
      tree_for_char_literal24 = @adaptor.create_with_payload( char_literal24 )
      @adaptor.add_child( root_0, tree_for_char_literal24 )


      # at line 87:7: ( NL )*
      while true # decision 8
        alt_8 = 2
        look_8_0 = @input.peek( 1 )

        if ( look_8_0 == NL )
          alt_8 = 1

        end
        case alt_8
        when 1
          # at line 87:7: NL
          __NL25__ = match( NL, TOKENS_FOLLOWING_NL_IN_state_207 )
          tree_for_NL25 = @adaptor.create_with_payload( __NL25__ )
          @adaptor.add_child( root_0, tree_for_NL25 )



        else
          break # out of loop for decision 8
        end
      end # loop for decision 8

      # at line 88:3: ( attribute )*
      while true # decision 9
        alt_9 = 2
        look_9_0 = @input.peek( 1 )

        if ( look_9_0 == ID || look_9_0 == T__56 )
          alt_9 = 1

        end
        case alt_9
        when 1
          # at line 88:3: attribute
          @state.following.push( TOKENS_FOLLOWING_attribute_IN_state_212 )
          attribute26 = attribute
          @state.following.pop
          @adaptor.add_child( root_0, attribute26.tree )


        else
          break # out of loop for decision 9
        end
      end # loop for decision 9

      char_literal27 = match( T__86, TOKENS_FOLLOWING_T__86_IN_state_217 )
      tree_for_char_literal27 = @adaptor.create_with_payload( char_literal27 )
      @adaptor.add_child( root_0, tree_for_char_literal27 )



      # --> action
      	self.goto_parent(true)	
      # <-- action


      # - - - - - - - rule clean up - - - - - - - -
      return_value.stop = @input.look( -1 )


      return_value.tree = @adaptor.rule_post_processing( root_0 )
      @adaptor.set_token_boundaries( return_value.tree, return_value.start, return_value.stop )


      rescue ANTLR3::Error::RecognitionError => re
        report_error(re)
        recover(re)
        return_value.tree = @adaptor.create_error_node( @input, return_value.start, @input.look(-1), re )


      ensure
        # -> uncomment the next line to manually enable rule tracing
        # trace_out( __method__, 6 )


      end

      return return_value
    end

    ClassDefReturnValue = define_return_scope

    #
    # parser rule class_def
    #
    # (in SfpLang.g)
    # 93:1: class_def : ( 'class' | 'schema' ) ID ( extends_class )? ( '{' ( NL )* ( attribute | procedure ( NL )* )* '}' )? ;
    #
    def class_def
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 7 )


      return_value = ClassDefReturnValue.new

      # $rule.start = the first token seen before matching
      return_value.start = @input.look


      root_0 = nil

      set28 = nil
      __ID29__ = nil
      char_literal31 = nil
      __NL32__ = nil
      __NL35__ = nil
      char_literal36 = nil
      extends_class30 = nil
      attribute33 = nil
      procedure34 = nil


      tree_for_set28 = nil
      tree_for_ID29 = nil
      tree_for_char_literal31 = nil
      tree_for_NL32 = nil
      tree_for_NL35 = nil
      tree_for_char_literal36 = nil

      begin
      root_0 = @adaptor.create_flat_list


      # at line 94:4: ( 'class' | 'schema' ) ID ( extends_class )? ( '{' ( NL )* ( attribute | procedure ( NL )* )* '}' )?
      set28 = @input.look

      if @input.peek(1) == T__45 || @input.peek(1) == T__77
        @input.consume
        @adaptor.add_child( root_0, @adaptor.create_with_payload( set28 ) )

        @state.error_recovery = false

      else
        mse = MismatchedSet( nil )
        raise mse

      end


      __ID29__ = match( ID, TOKENS_FOLLOWING_ID_IN_class_def_238 )
      tree_for_ID29 = @adaptor.create_with_payload( __ID29__ )
      @adaptor.add_child( root_0, tree_for_ID29 )



      # --> action

      			@now[__ID29__.text] = { '_self' => __ID29__.text,
      				'_context' => 'class',
      				'_parent' => @now,
      			}
      			@now = @now[__ID29__.text]
      		
      # <-- action

      # at line 102:3: ( extends_class )?
      alt_10 = 2
      look_10_0 = @input.peek( 1 )

      if ( look_10_0 == T__55 )
        alt_10 = 1
      end
      case alt_10
      when 1
        # at line 102:4: extends_class
        @state.following.push( TOKENS_FOLLOWING_extends_class_IN_class_def_247 )
        extends_class30 = extends_class
        @state.following.pop
        @adaptor.add_child( root_0, extends_class30.tree )


        # --> action

        			@now['_extends'] = ( extends_class30.nil? ? nil : extends_class30.val )
        		
        # <-- action


      end
      # at line 107:3: ( '{' ( NL )* ( attribute | procedure ( NL )* )* '}' )?
      alt_14 = 2
      look_14_0 = @input.peek( 1 )

      if ( look_14_0 == T__85 )
        alt_14 = 1
      end
      case alt_14
      when 1
        # at line 107:4: '{' ( NL )* ( attribute | procedure ( NL )* )* '}'
        char_literal31 = match( T__85, TOKENS_FOLLOWING_T__85_IN_class_def_261 )
        tree_for_char_literal31 = @adaptor.create_with_payload( char_literal31 )
        @adaptor.add_child( root_0, tree_for_char_literal31 )


        # at line 107:8: ( NL )*
        while true # decision 11
          alt_11 = 2
          look_11_0 = @input.peek( 1 )

          if ( look_11_0 == NL )
            alt_11 = 1

          end
          case alt_11
          when 1
            # at line 107:8: NL
            __NL32__ = match( NL, TOKENS_FOLLOWING_NL_IN_class_def_263 )
            tree_for_NL32 = @adaptor.create_with_payload( __NL32__ )
            @adaptor.add_child( root_0, tree_for_NL32 )



          else
            break # out of loop for decision 11
          end
        end # loop for decision 11

        # at line 107:12: ( attribute | procedure ( NL )* )*
        while true # decision 13
          alt_13 = 3
          look_13_0 = @input.peek( 1 )

          if ( look_13_0 == ID || look_13_0 == T__56 )
            alt_13 = 1
          elsif ( look_13_0 == T__75 || look_13_0.between?( T__80, T__81 ) )
            alt_13 = 2

          end
          case alt_13
          when 1
            # at line 107:14: attribute
            @state.following.push( TOKENS_FOLLOWING_attribute_IN_class_def_268 )
            attribute33 = attribute
            @state.following.pop
            @adaptor.add_child( root_0, attribute33.tree )


          when 2
            # at line 107:26: procedure ( NL )*
            @state.following.push( TOKENS_FOLLOWING_procedure_IN_class_def_272 )
            procedure34 = procedure
            @state.following.pop
            @adaptor.add_child( root_0, procedure34.tree )

            # at line 107:36: ( NL )*
            while true # decision 12
              alt_12 = 2
              look_12_0 = @input.peek( 1 )

              if ( look_12_0 == NL )
                alt_12 = 1

              end
              case alt_12
              when 1
                # at line 107:36: NL
                __NL35__ = match( NL, TOKENS_FOLLOWING_NL_IN_class_def_274 )
                tree_for_NL35 = @adaptor.create_with_payload( __NL35__ )
                @adaptor.add_child( root_0, tree_for_NL35 )



              else
                break # out of loop for decision 12
              end
            end # loop for decision 12


          else
            break # out of loop for decision 13
          end
        end # loop for decision 13

        char_literal36 = match( T__86, TOKENS_FOLLOWING_T__86_IN_class_def_280 )
        tree_for_char_literal36 = @adaptor.create_with_payload( char_literal36 )
        @adaptor.add_child( root_0, tree_for_char_literal36 )



      end

      # --> action

      			if not @now.has_key?('_extends')
      				@now['_extends'] = '$.Object'
      				@now['_super'] = ['$.Object']
      			end
      			expand_class(@now)
      			self.goto_parent()
      		
      # <-- action


      # - - - - - - - rule clean up - - - - - - - -
      return_value.stop = @input.look( -1 )


      return_value.tree = @adaptor.rule_post_processing( root_0 )
      @adaptor.set_token_boundaries( return_value.tree, return_value.start, return_value.stop )


      rescue ANTLR3::Error::RecognitionError => re
        report_error(re)
        recover(re)
        return_value.tree = @adaptor.create_error_node( @input, return_value.start, @input.look(-1), re )


      ensure
        # -> uncomment the next line to manually enable rule tracing
        # trace_out( __method__, 7 )


      end

      return return_value
    end

    ExtendsClassReturnValue = define_return_scope :val

    #
    # parser rule extends_class
    #
    # (in SfpLang.g)
    # 118:1: extends_class returns [val] : 'extends' path ;
    #
    def extends_class
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 8 )


      return_value = ExtendsClassReturnValue.new

      # $rule.start = the first token seen before matching
      return_value.start = @input.look


      root_0 = nil

      string_literal37 = nil
      path38 = nil


      tree_for_string_literal37 = nil

      begin
      root_0 = @adaptor.create_flat_list


      # at line 119:4: 'extends' path
      string_literal37 = match( T__55, TOKENS_FOLLOWING_T__55_IN_extends_class_302 )
      tree_for_string_literal37 = @adaptor.create_with_payload( string_literal37 )
      @adaptor.add_child( root_0, tree_for_string_literal37 )


      @state.following.push( TOKENS_FOLLOWING_path_IN_extends_class_304 )
      path38 = path
      @state.following.pop
      @adaptor.add_child( root_0, path38.tree )


      # --> action

      			return_value.val = self.to_ref(( path38 && @input.to_s( path38.start, path38.stop ) ))
      			@unexpanded_classes.push(@now)
      		
      # <-- action


      # - - - - - - - rule clean up - - - - - - - -
      return_value.stop = @input.look( -1 )


      return_value.tree = @adaptor.rule_post_processing( root_0 )
      @adaptor.set_token_boundaries( return_value.tree, return_value.start, return_value.stop )


      rescue ANTLR3::Error::RecognitionError => re
        report_error(re)
        recover(re)
        return_value.tree = @adaptor.create_error_node( @input, return_value.start, @input.look(-1), re )


      ensure
        # -> uncomment the next line to manually enable rule tracing
        # trace_out( __method__, 8 )


      end

      return return_value
    end

    AttributeReturnValue = define_return_scope

    #
    # parser rule attribute
    #
    # (in SfpLang.g)
    # 126:1: attribute : ( ( 'final' )? ID assignment[$ID.text] | ( 'final' )? object_def ( NL )+ );
    #
    def attribute
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 9 )


      return_value = AttributeReturnValue.new

      # $rule.start = the first token seen before matching
      return_value.start = @input.look


      root_0 = nil

      string_literal39 = nil
      __ID40__ = nil
      string_literal42 = nil
      __NL44__ = nil
      assignment41 = nil
      object_def43 = nil


      tree_for_string_literal39 = nil
      tree_for_ID40 = nil
      tree_for_string_literal42 = nil
      tree_for_NL44 = nil

      begin
      # at line 127:2: ( ( 'final' )? ID assignment[$ID.text] | ( 'final' )? object_def ( NL )+ )
      alt_18 = 2
      look_18_0 = @input.peek( 1 )

      if ( look_18_0 == T__56 )
        look_18_1 = @input.peek( 2 )

        if ( look_18_1 == ID )
          look_18_2 = @input.peek( 3 )

          if ( look_18_2 == T__28 || look_18_2 == T__32 || look_18_2 == T__53 || look_18_2 == T__66 || look_18_2.between?( T__70, T__71 ) )
            alt_18 = 1
          elsif ( look_18_2 == NL || look_18_2 == T__55 || look_18_2 == T__67 || look_18_2 == T__85 )
            alt_18 = 2
          else
            raise NoViableAlternative( "", 18, 2 )

          end
        else
          raise NoViableAlternative( "", 18, 1 )

        end
      elsif ( look_18_0 == ID )
        look_18_2 = @input.peek( 2 )

        if ( look_18_2 == T__28 || look_18_2 == T__32 || look_18_2 == T__53 || look_18_2 == T__66 || look_18_2.between?( T__70, T__71 ) )
          alt_18 = 1
        elsif ( look_18_2 == NL || look_18_2 == T__55 || look_18_2 == T__67 || look_18_2 == T__85 )
          alt_18 = 2
        else
          raise NoViableAlternative( "", 18, 2 )

        end
      else
        raise NoViableAlternative( "", 18, 0 )

      end
      case alt_18
      when 1
        root_0 = @adaptor.create_flat_list


        # at line 127:4: ( 'final' )? ID assignment[$ID.text]
        # --> action

        			@is_final = false
        			@now['_finals'] = [] if !@now.has_key? '_finals'
        		
        # <-- action

        # at line 131:3: ( 'final' )?
        alt_15 = 2
        look_15_0 = @input.peek( 1 )

        if ( look_15_0 == T__56 )
          alt_15 = 1
        end
        case alt_15
        when 1
          # at line 131:4: 'final'
          string_literal39 = match( T__56, TOKENS_FOLLOWING_T__56_IN_attribute_324 )
          tree_for_string_literal39 = @adaptor.create_with_payload( string_literal39 )
          @adaptor.add_child( root_0, tree_for_string_literal39 )



          # --> action
           @is_final = true 
          # <-- action


        end
        __ID40__ = match( ID, TOKENS_FOLLOWING_ID_IN_attribute_332 )
        tree_for_ID40 = @adaptor.create_with_payload( __ID40__ )
        @adaptor.add_child( root_0, tree_for_ID40 )


        @state.following.push( TOKENS_FOLLOWING_assignment_IN_attribute_334 )
        assignment41 = assignment( __ID40__.text )
        @state.following.pop
        @adaptor.add_child( root_0, assignment41.tree )


        # --> action

        			@now['_finals'] << __ID40__.text if @is_final
        		
        # <-- action


      when 2
        root_0 = @adaptor.create_flat_list


        # at line 136:4: ( 'final' )? object_def ( NL )+
        # --> action

        			@is_final = false
        			@now['_finals'] = [] if !@now.has_key? '_finals'
        		
        # <-- action

        # at line 140:3: ( 'final' )?
        alt_16 = 2
        look_16_0 = @input.peek( 1 )

        if ( look_16_0 == T__56 )
          alt_16 = 1
        end
        case alt_16
        when 1
          # at line 140:4: 'final'
          string_literal42 = match( T__56, TOKENS_FOLLOWING_T__56_IN_attribute_349 )
          tree_for_string_literal42 = @adaptor.create_with_payload( string_literal42 )
          @adaptor.add_child( root_0, tree_for_string_literal42 )



          # --> action
           @is_final = true 
          # <-- action


        end
        @state.following.push( TOKENS_FOLLOWING_object_def_IN_attribute_355 )
        object_def43 = object_def
        @state.following.pop
        @adaptor.add_child( root_0, object_def43.tree )

        # at file 140:46: ( NL )+
        match_count_17 = 0
        while true
          alt_17 = 2
          look_17_0 = @input.peek( 1 )

          if ( look_17_0 == NL )
            alt_17 = 1

          end
          case alt_17
          when 1
            # at line 140:46: NL
            __NL44__ = match( NL, TOKENS_FOLLOWING_NL_IN_attribute_357 )
            tree_for_NL44 = @adaptor.create_with_payload( __NL44__ )
            @adaptor.add_child( root_0, tree_for_NL44 )



          else
            match_count_17 > 0 and break
            eee = EarlyExit(17)


            raise eee
          end
          match_count_17 += 1
        end



      end
      # - - - - - - - rule clean up - - - - - - - -
      return_value.stop = @input.look( -1 )


      return_value.tree = @adaptor.rule_post_processing( root_0 )
      @adaptor.set_token_boundaries( return_value.tree, return_value.start, return_value.stop )


      rescue ANTLR3::Error::RecognitionError => re
        report_error(re)
        recover(re)
        return_value.tree = @adaptor.create_error_node( @input, return_value.start, @input.look(-1), re )


      ensure
        # -> uncomment the next line to manually enable rule tracing
        # trace_out( __method__, 9 )


      end

      return return_value
    end

    AssignmentReturnValue = define_return_scope

    #
    # parser rule assignment
    #
    # (in SfpLang.g)
    # 143:1: assignment[id] : ( equals_op value ( NL )+ | reference_type ( NL )+ | set_type ( NL )+ | probability_op set_value ( NL )+ | ':' path ( NL )+ );
    #
    def assignment( id )
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 10 )


      return_value = AssignmentReturnValue.new

      # $rule.start = the first token seen before matching
      return_value.start = @input.look


      root_0 = nil

      __NL47__ = nil
      __NL49__ = nil
      __NL51__ = nil
      __NL54__ = nil
      char_literal55 = nil
      __NL57__ = nil
      equals_op45 = nil
      value46 = nil
      reference_type48 = nil
      set_type50 = nil
      probability_op52 = nil
      set_value53 = nil
      path56 = nil


      tree_for_NL47 = nil
      tree_for_NL49 = nil
      tree_for_NL51 = nil
      tree_for_NL54 = nil
      tree_for_char_literal55 = nil
      tree_for_NL57 = nil

      begin
      # at line 144:2: ( equals_op value ( NL )+ | reference_type ( NL )+ | set_type ( NL )+ | probability_op set_value ( NL )+ | ':' path ( NL )+ )
      alt_24 = 5
      case look_24 = @input.peek( 1 )
      when T__32, T__66 then alt_24 = 1
      when T__70 then alt_24 = 2
      when T__71 then alt_24 = 3
      when T__53 then alt_24 = 4
      when T__28 then alt_24 = 5
      else
        raise NoViableAlternative( "", 24, 0 )

      end
      case alt_24
      when 1
        root_0 = @adaptor.create_flat_list


        # at line 144:4: equals_op value ( NL )+
        @state.following.push( TOKENS_FOLLOWING_equals_op_IN_assignment_370 )
        equals_op45 = equals_op
        @state.following.pop
        @adaptor.add_child( root_0, equals_op45.tree )

        @state.following.push( TOKENS_FOLLOWING_value_IN_assignment_372 )
        value46 = value
        @state.following.pop
        @adaptor.add_child( root_0, value46.tree )

        # at file 144:20: ( NL )+
        match_count_19 = 0
        while true
          alt_19 = 2
          look_19_0 = @input.peek( 1 )

          if ( look_19_0 == NL )
            alt_19 = 1

          end
          case alt_19
          when 1
            # at line 144:20: NL
            __NL47__ = match( NL, TOKENS_FOLLOWING_NL_IN_assignment_374 )
            tree_for_NL47 = @adaptor.create_with_payload( __NL47__ )
            @adaptor.add_child( root_0, tree_for_NL47 )



          else
            match_count_19 > 0 and break
            eee = EarlyExit(19)


            raise eee
          end
          match_count_19 += 1
        end



        # --> action

        			if @now.has_key?(id) and @now[id].is_a?(Hash) and
        					@now[id].isset and ( value46.nil? ? nil : value46.type ) == 'Set'
        				( value46.nil? ? nil : value46.val ).each { |v| @now[id]['_values'].push(v) }
        			else
        				@now[id] = ( value46.nil? ? nil : value46.val )
        			end
        		
        # <-- action


      when 2
        root_0 = @adaptor.create_flat_list


        # at line 153:4: reference_type ( NL )+
        @state.following.push( TOKENS_FOLLOWING_reference_type_IN_assignment_384 )
        reference_type48 = reference_type
        @state.following.pop
        @adaptor.add_child( root_0, reference_type48.tree )

        # at file 153:19: ( NL )+
        match_count_20 = 0
        while true
          alt_20 = 2
          look_20_0 = @input.peek( 1 )

          if ( look_20_0 == NL )
            alt_20 = 1

          end
          case alt_20
          when 1
            # at line 153:19: NL
            __NL49__ = match( NL, TOKENS_FOLLOWING_NL_IN_assignment_386 )
            tree_for_NL49 = @adaptor.create_with_payload( __NL49__ )
            @adaptor.add_child( root_0, tree_for_NL49 )



          else
            match_count_20 > 0 and break
            eee = EarlyExit(20)


            raise eee
          end
          match_count_20 += 1
        end



        # --> action

        			@now[id] = ( reference_type48.nil? ? nil : reference_type48.val )
        		
        # <-- action


      when 3
        root_0 = @adaptor.create_flat_list


        # at line 157:4: set_type ( NL )+
        @state.following.push( TOKENS_FOLLOWING_set_type_IN_assignment_396 )
        set_type50 = set_type
        @state.following.pop
        @adaptor.add_child( root_0, set_type50.tree )

        # at file 157:13: ( NL )+
        match_count_21 = 0
        while true
          alt_21 = 2
          look_21_0 = @input.peek( 1 )

          if ( look_21_0 == NL )
            alt_21 = 1

          end
          case alt_21
          when 1
            # at line 157:13: NL
            __NL51__ = match( NL, TOKENS_FOLLOWING_NL_IN_assignment_398 )
            tree_for_NL51 = @adaptor.create_with_payload( __NL51__ )
            @adaptor.add_child( root_0, tree_for_NL51 )



          else
            match_count_21 > 0 and break
            eee = EarlyExit(21)


            raise eee
          end
          match_count_21 += 1
        end



        # --> action

        			@now[id] = ( set_type50.nil? ? nil : set_type50.val )
        		
        # <-- action


      when 4
        root_0 = @adaptor.create_flat_list


        # at line 161:4: probability_op set_value ( NL )+
        @state.following.push( TOKENS_FOLLOWING_probability_op_IN_assignment_408 )
        probability_op52 = probability_op
        @state.following.pop
        @adaptor.add_child( root_0, probability_op52.tree )

        @state.following.push( TOKENS_FOLLOWING_set_value_IN_assignment_410 )
        set_value53 = set_value
        @state.following.pop
        @adaptor.add_child( root_0, set_value53.tree )

        # at file 161:29: ( NL )+
        match_count_22 = 0
        while true
          alt_22 = 2
          look_22_0 = @input.peek( 1 )

          if ( look_22_0 == NL )
            alt_22 = 1

          end
          case alt_22
          when 1
            # at line 161:29: NL
            __NL54__ = match( NL, TOKENS_FOLLOWING_NL_IN_assignment_412 )
            tree_for_NL54 = @adaptor.create_with_payload( __NL54__ )
            @adaptor.add_child( root_0, tree_for_NL54 )



          else
            match_count_22 > 0 and break
            eee = EarlyExit(22)


            raise eee
          end
          match_count_22 += 1
        end



        # --> action
         	
        			@conformant = true
        			@now[id] = { '_self' => id,
        				'_context' => 'either',
        				'_parent' => @now,
        				'_values' => ( set_value53.nil? ? nil : set_value53.val )
        			}
        		
        # <-- action


      when 5
        root_0 = @adaptor.create_flat_list


        # at line 170:4: ':' path ( NL )+
        char_literal55 = match( T__28, TOKENS_FOLLOWING_T__28_IN_assignment_422 )
        tree_for_char_literal55 = @adaptor.create_with_payload( char_literal55 )
        @adaptor.add_child( root_0, tree_for_char_literal55 )


        @state.following.push( TOKENS_FOLLOWING_path_IN_assignment_424 )
        path56 = path
        @state.following.pop
        @adaptor.add_child( root_0, path56.tree )

        # at file 170:13: ( NL )+
        match_count_23 = 0
        while true
          alt_23 = 2
          look_23_0 = @input.peek( 1 )

          if ( look_23_0 == NL )
            alt_23 = 1

          end
          case alt_23
          when 1
            # at line 170:13: NL
            __NL57__ = match( NL, TOKENS_FOLLOWING_NL_IN_assignment_426 )
            tree_for_NL57 = @adaptor.create_with_payload( __NL57__ )
            @adaptor.add_child( root_0, tree_for_NL57 )



          else
            match_count_23 > 0 and break
            eee = EarlyExit(23)


            raise eee
          end
          match_count_23 += 1
        end



        # --> action

        			case ( path56 && @input.to_s( path56.start, path56.stop ) )
        			when 'String'
        				@now[id] = { '_context' => 'any_value',
        					'_isa' => '$.String'
        				}
        			when 'Bool'
        				@now[id] = { '_context' => 'any_value',
        					'_isa' => '$.Boolean'
        				}
        			when 'Int'
        				@now[id] = { '_context' => 'any_value',
        					'_isa' => '$.Number'
        				}
        			else
        				raise Exception, "Use isa/isref for any non-primitive type (#{( path56 && @input.to_s( path56.start, path56.stop ) )})."
        			end
        		
        # <-- action


      end
      # - - - - - - - rule clean up - - - - - - - -
      return_value.stop = @input.look( -1 )


      return_value.tree = @adaptor.rule_post_processing( root_0 )
      @adaptor.set_token_boundaries( return_value.tree, return_value.start, return_value.stop )


      rescue ANTLR3::Error::RecognitionError => re
        report_error(re)
        recover(re)
        return_value.tree = @adaptor.create_error_node( @input, return_value.start, @input.look(-1), re )


      ensure
        # -> uncomment the next line to manually enable rule tracing
        # trace_out( __method__, 10 )


      end

      return return_value
    end

    ObjectSchemaReturnValue = define_return_scope

    #
    # parser rule object_schema
    #
    # (in SfpLang.g)
    # 191:1: object_schema : path ( '[' NUMBER ']' )? ;
    #
    def object_schema
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 11 )


      return_value = ObjectSchemaReturnValue.new

      # $rule.start = the first token seen before matching
      return_value.start = @input.look


      root_0 = nil

      char_literal59 = nil
      __NUMBER60__ = nil
      char_literal61 = nil
      path58 = nil


      tree_for_char_literal59 = nil
      tree_for_NUMBER60 = nil
      tree_for_char_literal61 = nil

      begin
      root_0 = @adaptor.create_flat_list


      # at line 192:4: path ( '[' NUMBER ']' )?
      @state.following.push( TOKENS_FOLLOWING_path_IN_object_schema_442 )
      path58 = path
      @state.following.pop
      @adaptor.add_child( root_0, path58.tree )

      # at line 192:8: ( '[' NUMBER ']' )?
      alt_25 = 2
      look_25_0 = @input.peek( 1 )

      if ( look_25_0 == T__35 )
        alt_25 = 1
      end
      case alt_25
      when 1
        # at line 192:9: '[' NUMBER ']'
        char_literal59 = match( T__35, TOKENS_FOLLOWING_T__35_IN_object_schema_444 )
        tree_for_char_literal59 = @adaptor.create_with_payload( char_literal59 )
        @adaptor.add_child( root_0, tree_for_char_literal59 )


        __NUMBER60__ = match( NUMBER, TOKENS_FOLLOWING_NUMBER_IN_object_schema_446 )
        tree_for_NUMBER60 = @adaptor.create_with_payload( __NUMBER60__ )
        @adaptor.add_child( root_0, tree_for_NUMBER60 )



        # --> action
         @now['_is_array'] = true 
        # <-- action

        char_literal61 = match( T__36, TOKENS_FOLLOWING_T__36_IN_object_schema_450 )
        tree_for_char_literal61 = @adaptor.create_with_payload( char_literal61 )
        @adaptor.add_child( root_0, tree_for_char_literal61 )



      end

      # --> action

      			@now['_isa'] = self.to_ref(( path58 && @input.to_s( path58.start, path58.stop ) ))
      			self.expand_object(@now)
      		
      # <-- action


      # - - - - - - - rule clean up - - - - - - - -
      return_value.stop = @input.look( -1 )


      return_value.tree = @adaptor.rule_post_processing( root_0 )
      @adaptor.set_token_boundaries( return_value.tree, return_value.start, return_value.stop )


      rescue ANTLR3::Error::RecognitionError => re
        report_error(re)
        recover(re)
        return_value.tree = @adaptor.create_error_node( @input, return_value.start, @input.look(-1), re )


      ensure
        # -> uncomment the next line to manually enable rule tracing
        # trace_out( __method__, 11 )


      end

      return return_value
    end

    ObjectSchemataReturnValue = define_return_scope

    #
    # parser rule object_schemata
    #
    # (in SfpLang.g)
    # 199:1: object_schemata : ',' object_schema ;
    #
    def object_schemata
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 12 )


      return_value = ObjectSchemataReturnValue.new

      # $rule.start = the first token seen before matching
      return_value.start = @input.look


      root_0 = nil

      char_literal62 = nil
      object_schema63 = nil


      tree_for_char_literal62 = nil

      begin
      root_0 = @adaptor.create_flat_list


      # at line 200:4: ',' object_schema
      char_literal62 = match( T__24, TOKENS_FOLLOWING_T__24_IN_object_schemata_467 )
      tree_for_char_literal62 = @adaptor.create_with_payload( char_literal62 )
      @adaptor.add_child( root_0, tree_for_char_literal62 )


      @state.following.push( TOKENS_FOLLOWING_object_schema_IN_object_schemata_469 )
      object_schema63 = object_schema
      @state.following.pop
      @adaptor.add_child( root_0, object_schema63.tree )


      # - - - - - - - rule clean up - - - - - - - -
      return_value.stop = @input.look( -1 )


      return_value.tree = @adaptor.rule_post_processing( root_0 )
      @adaptor.set_token_boundaries( return_value.tree, return_value.start, return_value.stop )


      rescue ANTLR3::Error::RecognitionError => re
        report_error(re)
        recover(re)
        return_value.tree = @adaptor.create_error_node( @input, return_value.start, @input.look(-1), re )


      ensure
        # -> uncomment the next line to manually enable rule tracing
        # trace_out( __method__, 12 )


      end

      return return_value
    end

    AbstractObjectReturnValue = define_return_scope

    #
    # parser rule abstract_object
    #
    # (in SfpLang.g)
    # 203:1: abstract_object : 'abstract' object_def ;
    #
    def abstract_object
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 13 )


      return_value = AbstractObjectReturnValue.new

      # $rule.start = the first token seen before matching
      return_value.start = @input.look


      root_0 = nil

      string_literal64 = nil
      object_def65 = nil


      tree_for_string_literal64 = nil

      begin
      root_0 = @adaptor.create_flat_list


      # at line 204:4: 'abstract' object_def
      # --> action

      			@is_final = false
      			@now['_finals'] = [] if !@now.has_key? '_finals'
      		
      # <-- action

      string_literal64 = match( T__37, TOKENS_FOLLOWING_T__37_IN_abstract_object_484 )
      tree_for_string_literal64 = @adaptor.create_with_payload( string_literal64 )
      @adaptor.add_child( root_0, tree_for_string_literal64 )


      @state.following.push( TOKENS_FOLLOWING_object_def_IN_abstract_object_486 )
      object_def65 = object_def
      @state.following.pop
      @adaptor.add_child( root_0, object_def65.tree )


      # --> action
        @root[( object_def65.nil? ? nil : object_def65.id )]['_context'] = 'abstract'  
      # <-- action


      # - - - - - - - rule clean up - - - - - - - -
      return_value.stop = @input.look( -1 )


      return_value.tree = @adaptor.rule_post_processing( root_0 )
      @adaptor.set_token_boundaries( return_value.tree, return_value.start, return_value.stop )


      rescue ANTLR3::Error::RecognitionError => re
        report_error(re)
        recover(re)
        return_value.tree = @adaptor.create_error_node( @input, return_value.start, @input.look(-1), re )


      ensure
        # -> uncomment the next line to manually enable rule tracing
        # trace_out( __method__, 13 )


      end

      return return_value
    end

    ObjectDefReturnValue = define_return_scope :id

    #
    # parser rule object_def
    #
    # (in SfpLang.g)
    # 212:1: object_def returns [id] : ID ( 'extends' path )? ( 'isa' object_schema ( object_schemata )* )? ( object_body )? ;
    #
    def object_def
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 14 )


      return_value = ObjectDefReturnValue.new

      # $rule.start = the first token seen before matching
      return_value.start = @input.look


      root_0 = nil

      __ID66__ = nil
      string_literal67 = nil
      string_literal69 = nil
      path68 = nil
      object_schema70 = nil
      object_schemata71 = nil
      object_body72 = nil


      tree_for_ID66 = nil
      tree_for_string_literal67 = nil
      tree_for_string_literal69 = nil

      begin
      root_0 = @adaptor.create_flat_list


      # at line 213:4: ID ( 'extends' path )? ( 'isa' object_schema ( object_schemata )* )? ( object_body )?
      __ID66__ = match( ID, TOKENS_FOLLOWING_ID_IN_object_def_505 )
      tree_for_ID66 = @adaptor.create_with_payload( __ID66__ )
      @adaptor.add_child( root_0, tree_for_ID66 )



      # --> action
       return_value.id = __ID66__.text 
      # <-- action


      # --> action

      			@use_template = false
      			@now['_finals'] = [] if !@now.has_key? '_finals'
      			@now['_finals'] << __ID66__.text if @is_final
      		
      # <-- action

      # at line 219:3: ( 'extends' path )?
      alt_26 = 2
      look_26_0 = @input.peek( 1 )

      if ( look_26_0 == T__55 )
        alt_26 = 1
      end
      case alt_26
      when 1
        # at line 219:4: 'extends' path
        string_literal67 = match( T__55, TOKENS_FOLLOWING_T__55_IN_object_def_516 )
        tree_for_string_literal67 = @adaptor.create_with_payload( string_literal67 )
        @adaptor.add_child( root_0, tree_for_string_literal67 )


        @state.following.push( TOKENS_FOLLOWING_path_IN_object_def_518 )
        path68 = path
        @state.following.pop
        @adaptor.add_child( root_0, path68.tree )


        # --> action

        			template = @root.at?(( path68 && @input.to_s( path68.start, path68.stop ) ))
        			if template.is_a?(Sfp::Unknown) or template.is_a?(Sfp::Undefined)
        				raise Exception, "Object template #{( path68 && @input.to_s( path68.start, path68.stop ) )} is not found!"
        			end
        			if !template.is_a?(Hash) or (template['_context'] != 'object' and template['_context'] != 'abstract')
        puts template['_context']
        				raise Exception, "#{( path68 && @input.to_s( path68.start, path68.stop ) )}:[#{template['_context']}] is not an object or an abstract object!"
        			end
        			object = @now[__ID66__.text] = Sfp::Helper.deep_clone(template)
        			object.accept(Sfp::Visitor::ParentEliminator.new)
        			object['_parent'] = @now
        			object['_self'] = __ID66__.text
        			object['_context'] = 'object'
        			object.accept(Sfp::Visitor::SfpGenerator.new(@root))
        			@use_template = true
        		
        # <-- action


      end

      # --> action

      			@now[__ID66__.text] = {	'_self' => __ID66__.text,
      				'_context' => 'object',
      				'_parent' => @now,
      				'_isa' => '$.Object'
      			} if not @use_template
      			@now = @now[__ID66__.text]
      			@now['_is_array'] = false
      		
      # <-- action

      # at line 247:3: ( 'isa' object_schema ( object_schemata )* )?
      alt_28 = 2
      look_28_0 = @input.peek( 1 )

      if ( look_28_0 == T__67 )
        alt_28 = 1
      end
      case alt_28
      when 1
        # at line 247:4: 'isa' object_schema ( object_schemata )*
        string_literal69 = match( T__67, TOKENS_FOLLOWING_T__67_IN_object_def_536 )
        tree_for_string_literal69 = @adaptor.create_with_payload( string_literal69 )
        @adaptor.add_child( root_0, tree_for_string_literal69 )


        @state.following.push( TOKENS_FOLLOWING_object_schema_IN_object_def_538 )
        object_schema70 = object_schema
        @state.following.pop
        @adaptor.add_child( root_0, object_schema70.tree )

        # at line 247:24: ( object_schemata )*
        while true # decision 27
          alt_27 = 2
          look_27_0 = @input.peek( 1 )

          if ( look_27_0 == T__24 )
            alt_27 = 1

          end
          case alt_27
          when 1
            # at line 247:25: object_schemata
            @state.following.push( TOKENS_FOLLOWING_object_schemata_IN_object_def_541 )
            object_schemata71 = object_schemata
            @state.following.pop
            @adaptor.add_child( root_0, object_schemata71.tree )


          else
            break # out of loop for decision 27
          end
        end # loop for decision 27


      end
      # at line 248:3: ( object_body )?
      alt_29 = 2
      look_29_0 = @input.peek( 1 )

      if ( look_29_0 == T__85 )
        alt_29 = 1
      end
      case alt_29
      when 1
        # at line 248:3: object_body
        @state.following.push( TOKENS_FOLLOWING_object_body_IN_object_def_550 )
        object_body72 = object_body
        @state.following.pop
        @adaptor.add_child( root_0, object_body72.tree )


      end

      # --> action

      			if @now['_is_array']
      				@now.delete('_is_array')
      				obj = self.goto_parent()
      				total = $NUMBER.to_s.to_i
      				@arrays[obj.ref] = total
      				for i in 0..(total-1)
      					id = obj['_self'] + '[' + i.to_s + ']'
      					@now[id] = deep_clone(obj)
      					@now[id]['_self'] = id
      					@now[id]['_classes'] = obj['_classes']
      				end
      				@now.delete(obj['_self'])
      			else
      				self.goto_parent()
      			end
      		
      # <-- action


      # - - - - - - - rule clean up - - - - - - - -
      return_value.stop = @input.look( -1 )


      return_value.tree = @adaptor.rule_post_processing( root_0 )
      @adaptor.set_token_boundaries( return_value.tree, return_value.start, return_value.stop )


      rescue ANTLR3::Error::RecognitionError => re
        report_error(re)
        recover(re)
        return_value.tree = @adaptor.create_error_node( @input, return_value.start, @input.look(-1), re )


      ensure
        # -> uncomment the next line to manually enable rule tracing
        # trace_out( __method__, 14 )


      end

      return return_value
    end

    ObjectBodyReturnValue = define_return_scope

    #
    # parser rule object_body
    #
    # (in SfpLang.g)
    # 268:1: object_body : '{' ( NL )* ( object_attribute | procedure ( NL )* )* '}' ;
    #
    def object_body
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 15 )


      return_value = ObjectBodyReturnValue.new

      # $rule.start = the first token seen before matching
      return_value.start = @input.look


      root_0 = nil

      char_literal73 = nil
      __NL74__ = nil
      __NL77__ = nil
      char_literal78 = nil
      object_attribute75 = nil
      procedure76 = nil


      tree_for_char_literal73 = nil
      tree_for_NL74 = nil
      tree_for_NL77 = nil
      tree_for_char_literal78 = nil

      begin
      root_0 = @adaptor.create_flat_list


      # at line 269:4: '{' ( NL )* ( object_attribute | procedure ( NL )* )* '}'
      char_literal73 = match( T__85, TOKENS_FOLLOWING_T__85_IN_object_body_566 )
      tree_for_char_literal73 = @adaptor.create_with_payload( char_literal73 )
      @adaptor.add_child( root_0, tree_for_char_literal73 )


      # at line 269:8: ( NL )*
      while true # decision 30
        alt_30 = 2
        look_30_0 = @input.peek( 1 )

        if ( look_30_0 == NL )
          alt_30 = 1

        end
        case alt_30
        when 1
          # at line 269:8: NL
          __NL74__ = match( NL, TOKENS_FOLLOWING_NL_IN_object_body_568 )
          tree_for_NL74 = @adaptor.create_with_payload( __NL74__ )
          @adaptor.add_child( root_0, tree_for_NL74 )



        else
          break # out of loop for decision 30
        end
      end # loop for decision 30

      # at line 269:12: ( object_attribute | procedure ( NL )* )*
      while true # decision 32
        alt_32 = 3
        look_32_0 = @input.peek( 1 )

        if ( look_32_0 == ID || look_32_0 == T__56 )
          alt_32 = 1
        elsif ( look_32_0 == T__75 || look_32_0.between?( T__80, T__81 ) )
          alt_32 = 2

        end
        case alt_32
        when 1
          # at line 269:14: object_attribute
          @state.following.push( TOKENS_FOLLOWING_object_attribute_IN_object_body_573 )
          object_attribute75 = object_attribute
          @state.following.pop
          @adaptor.add_child( root_0, object_attribute75.tree )


        when 2
          # at line 269:33: procedure ( NL )*
          @state.following.push( TOKENS_FOLLOWING_procedure_IN_object_body_577 )
          procedure76 = procedure
          @state.following.pop
          @adaptor.add_child( root_0, procedure76.tree )

          # at line 269:43: ( NL )*
          while true # decision 31
            alt_31 = 2
            look_31_0 = @input.peek( 1 )

            if ( look_31_0 == NL )
              alt_31 = 1

            end
            case alt_31
            when 1
              # at line 269:43: NL
              __NL77__ = match( NL, TOKENS_FOLLOWING_NL_IN_object_body_579 )
              tree_for_NL77 = @adaptor.create_with_payload( __NL77__ )
              @adaptor.add_child( root_0, tree_for_NL77 )



            else
              break # out of loop for decision 31
            end
          end # loop for decision 31


        else
          break # out of loop for decision 32
        end
      end # loop for decision 32

      char_literal78 = match( T__86, TOKENS_FOLLOWING_T__86_IN_object_body_585 )
      tree_for_char_literal78 = @adaptor.create_with_payload( char_literal78 )
      @adaptor.add_child( root_0, tree_for_char_literal78 )



      # - - - - - - - rule clean up - - - - - - - -
      return_value.stop = @input.look( -1 )


      return_value.tree = @adaptor.rule_post_processing( root_0 )
      @adaptor.set_token_boundaries( return_value.tree, return_value.start, return_value.stop )


      rescue ANTLR3::Error::RecognitionError => re
        report_error(re)
        recover(re)
        return_value.tree = @adaptor.create_error_node( @input, return_value.start, @input.look(-1), re )


      ensure
        # -> uncomment the next line to manually enable rule tracing
        # trace_out( __method__, 15 )


      end

      return return_value
    end

    ObjectAttributeReturnValue = define_return_scope

    #
    # parser rule object_attribute
    #
    # (in SfpLang.g)
    # 272:1: object_attribute : ( attribute | ID equals_op NULL ( NL )+ );
    #
    def object_attribute
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 16 )


      return_value = ObjectAttributeReturnValue.new

      # $rule.start = the first token seen before matching
      return_value.start = @input.look


      root_0 = nil

      __ID80__ = nil
      __NULL82__ = nil
      __NL83__ = nil
      attribute79 = nil
      equals_op81 = nil


      tree_for_ID80 = nil
      tree_for_NULL82 = nil
      tree_for_NL83 = nil

      begin
      # at line 273:2: ( attribute | ID equals_op NULL ( NL )+ )
      alt_34 = 2
      look_34_0 = @input.peek( 1 )

      if ( look_34_0 == T__56 )
        alt_34 = 1
      elsif ( look_34_0 == ID )
        look_34_2 = @input.peek( 2 )

        if ( look_34_2 == T__32 || look_34_2 == T__66 )
          look_34_3 = @input.peek( 3 )

          if ( look_34_3 == BOOLEAN || look_34_3.between?( ID, MULTILINE_STRING ) || look_34_3 == NUMBER || look_34_3 == STRING || look_34_3 == T__20 || look_34_3 == T__35 || look_34_3 == T__41 )
            alt_34 = 1
          elsif ( look_34_3 == NULL )
            alt_34 = 2
          else
            raise NoViableAlternative( "", 34, 3 )

          end
        elsif ( look_34_2 == NL || look_34_2 == T__28 || look_34_2 == T__53 || look_34_2 == T__55 || look_34_2 == T__67 || look_34_2.between?( T__70, T__71 ) || look_34_2 == T__85 )
          alt_34 = 1
        else
          raise NoViableAlternative( "", 34, 2 )

        end
      else
        raise NoViableAlternative( "", 34, 0 )

      end
      case alt_34
      when 1
        root_0 = @adaptor.create_flat_list


        # at line 273:4: attribute
        @state.following.push( TOKENS_FOLLOWING_attribute_IN_object_attribute_596 )
        attribute79 = attribute
        @state.following.pop
        @adaptor.add_child( root_0, attribute79.tree )


      when 2
        root_0 = @adaptor.create_flat_list


        # at line 274:4: ID equals_op NULL ( NL )+
        __ID80__ = match( ID, TOKENS_FOLLOWING_ID_IN_object_attribute_601 )
        tree_for_ID80 = @adaptor.create_with_payload( __ID80__ )
        @adaptor.add_child( root_0, tree_for_ID80 )


        @state.following.push( TOKENS_FOLLOWING_equals_op_IN_object_attribute_603 )
        equals_op81 = equals_op
        @state.following.pop
        @adaptor.add_child( root_0, equals_op81.tree )

        __NULL82__ = match( NULL, TOKENS_FOLLOWING_NULL_IN_object_attribute_605 )
        tree_for_NULL82 = @adaptor.create_with_payload( __NULL82__ )
        @adaptor.add_child( root_0, tree_for_NULL82 )


        # at file 274:22: ( NL )+
        match_count_33 = 0
        while true
          alt_33 = 2
          look_33_0 = @input.peek( 1 )

          if ( look_33_0 == NL )
            alt_33 = 1

          end
          case alt_33
          when 1
            # at line 274:22: NL
            __NL83__ = match( NL, TOKENS_FOLLOWING_NL_IN_object_attribute_607 )
            tree_for_NL83 = @adaptor.create_with_payload( __NL83__ )
            @adaptor.add_child( root_0, tree_for_NL83 )



          else
            match_count_33 > 0 and break
            eee = EarlyExit(33)


            raise eee
          end
          match_count_33 += 1
        end



        # --> action
        	@now[__ID80__.text] = self.null_value	
        # <-- action


      end
      # - - - - - - - rule clean up - - - - - - - -
      return_value.stop = @input.look( -1 )


      return_value.tree = @adaptor.rule_post_processing( root_0 )
      @adaptor.set_token_boundaries( return_value.tree, return_value.start, return_value.stop )


      rescue ANTLR3::Error::RecognitionError => re
        report_error(re)
        recover(re)
        return_value.tree = @adaptor.create_error_node( @input, return_value.start, @input.look(-1), re )


      ensure
        # -> uncomment the next line to manually enable rule tracing
        # trace_out( __method__, 16 )


      end

      return return_value
    end

    StateDependencyReturnValue = define_return_scope

    #
    # parser rule state_dependency
    #
    # (in SfpLang.g)
    # 278:1: state_dependency : 'if' dep_effect ( NL )* 'then' ( NL )* '{' ( NL )* constraint_body '}' ( ( NL )* 'or' ( NL )* '{' ( NL )* constraint_body '}' )* ( NL )+ ;
    #
    def state_dependency
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 17 )


      return_value = StateDependencyReturnValue.new

      # $rule.start = the first token seen before matching
      return_value.start = @input.look


      root_0 = nil

      string_literal84 = nil
      __NL86__ = nil
      string_literal87 = nil
      __NL88__ = nil
      char_literal89 = nil
      __NL90__ = nil
      char_literal92 = nil
      __NL93__ = nil
      string_literal94 = nil
      __NL95__ = nil
      char_literal96 = nil
      __NL97__ = nil
      char_literal99 = nil
      __NL100__ = nil
      dep_effect85 = nil
      constraint_body91 = nil
      constraint_body98 = nil


      tree_for_string_literal84 = nil
      tree_for_NL86 = nil
      tree_for_string_literal87 = nil
      tree_for_NL88 = nil
      tree_for_char_literal89 = nil
      tree_for_NL90 = nil
      tree_for_char_literal92 = nil
      tree_for_NL93 = nil
      tree_for_string_literal94 = nil
      tree_for_NL95 = nil
      tree_for_char_literal96 = nil
      tree_for_NL97 = nil
      tree_for_char_literal99 = nil
      tree_for_NL100 = nil

      begin
      root_0 = @adaptor.create_flat_list


      # at line 279:4: 'if' dep_effect ( NL )* 'then' ( NL )* '{' ( NL )* constraint_body '}' ( ( NL )* 'or' ( NL )* '{' ( NL )* constraint_body '}' )* ( NL )+
      string_literal84 = match( T__63, TOKENS_FOLLOWING_T__63_IN_state_dependency_623 )
      tree_for_string_literal84 = @adaptor.create_with_payload( string_literal84 )
      @adaptor.add_child( root_0, tree_for_string_literal84 )


      @state.following.push( TOKENS_FOLLOWING_dep_effect_IN_state_dependency_627 )
      dep_effect85 = dep_effect
      @state.following.pop
      @adaptor.add_child( root_0, dep_effect85.tree )

      # at line 280:14: ( NL )*
      while true # decision 35
        alt_35 = 2
        look_35_0 = @input.peek( 1 )

        if ( look_35_0 == NL )
          alt_35 = 1

        end
        case alt_35
        when 1
          # at line 280:14: NL
          __NL86__ = match( NL, TOKENS_FOLLOWING_NL_IN_state_dependency_629 )
          tree_for_NL86 = @adaptor.create_with_payload( __NL86__ )
          @adaptor.add_child( root_0, tree_for_NL86 )



        else
          break # out of loop for decision 35
        end
      end # loop for decision 35

      string_literal87 = match( T__82, TOKENS_FOLLOWING_T__82_IN_state_dependency_632 )
      tree_for_string_literal87 = @adaptor.create_with_payload( string_literal87 )
      @adaptor.add_child( root_0, tree_for_string_literal87 )


      # at line 280:25: ( NL )*
      while true # decision 36
        alt_36 = 2
        look_36_0 = @input.peek( 1 )

        if ( look_36_0 == NL )
          alt_36 = 1

        end
        case alt_36
        when 1
          # at line 280:25: NL
          __NL88__ = match( NL, TOKENS_FOLLOWING_NL_IN_state_dependency_634 )
          tree_for_NL88 = @adaptor.create_with_payload( __NL88__ )
          @adaptor.add_child( root_0, tree_for_NL88 )



        else
          break # out of loop for decision 36
        end
      end # loop for decision 36

      char_literal89 = match( T__85, TOKENS_FOLLOWING_T__85_IN_state_dependency_637 )
      tree_for_char_literal89 = @adaptor.create_with_payload( char_literal89 )
      @adaptor.add_child( root_0, tree_for_char_literal89 )


      # at line 281:3: ( NL )*
      while true # decision 37
        alt_37 = 2
        look_37_0 = @input.peek( 1 )

        if ( look_37_0 == NL )
          alt_37 = 1

        end
        case alt_37
        when 1
          # at line 281:3: NL
          __NL90__ = match( NL, TOKENS_FOLLOWING_NL_IN_state_dependency_641 )
          tree_for_NL90 = @adaptor.create_with_payload( __NL90__ )
          @adaptor.add_child( root_0, tree_for_NL90 )



        else
          break # out of loop for decision 37
        end
      end # loop for decision 37

      @state.following.push( TOKENS_FOLLOWING_constraint_body_IN_state_dependency_644 )
      constraint_body91 = constraint_body
      @state.following.pop
      @adaptor.add_child( root_0, constraint_body91.tree )

      char_literal92 = match( T__86, TOKENS_FOLLOWING_T__86_IN_state_dependency_649 )
      tree_for_char_literal92 = @adaptor.create_with_payload( char_literal92 )
      @adaptor.add_child( root_0, tree_for_char_literal92 )


      # at line 283:3: ( ( NL )* 'or' ( NL )* '{' ( NL )* constraint_body '}' )*
      while true # decision 41
        alt_41 = 2
        alt_41 = @dfa41.predict( @input )
        case alt_41
        when 1
          # at line 283:5: ( NL )* 'or' ( NL )* '{' ( NL )* constraint_body '}'
          # at line 283:5: ( NL )*
          while true # decision 38
            alt_38 = 2
            look_38_0 = @input.peek( 1 )

            if ( look_38_0 == NL )
              alt_38 = 1

            end
            case alt_38
            when 1
              # at line 283:5: NL
              __NL93__ = match( NL, TOKENS_FOLLOWING_NL_IN_state_dependency_655 )
              tree_for_NL93 = @adaptor.create_with_payload( __NL93__ )
              @adaptor.add_child( root_0, tree_for_NL93 )



            else
              break # out of loop for decision 38
            end
          end # loop for decision 38

          string_literal94 = match( T__74, TOKENS_FOLLOWING_T__74_IN_state_dependency_658 )
          tree_for_string_literal94 = @adaptor.create_with_payload( string_literal94 )
          @adaptor.add_child( root_0, tree_for_string_literal94 )


          # at line 283:14: ( NL )*
          while true # decision 39
            alt_39 = 2
            look_39_0 = @input.peek( 1 )

            if ( look_39_0 == NL )
              alt_39 = 1

            end
            case alt_39
            when 1
              # at line 283:14: NL
              __NL95__ = match( NL, TOKENS_FOLLOWING_NL_IN_state_dependency_660 )
              tree_for_NL95 = @adaptor.create_with_payload( __NL95__ )
              @adaptor.add_child( root_0, tree_for_NL95 )



            else
              break # out of loop for decision 39
            end
          end # loop for decision 39

          char_literal96 = match( T__85, TOKENS_FOLLOWING_T__85_IN_state_dependency_663 )
          tree_for_char_literal96 = @adaptor.create_with_payload( char_literal96 )
          @adaptor.add_child( root_0, tree_for_char_literal96 )


          # at line 284:3: ( NL )*
          while true # decision 40
            alt_40 = 2
            look_40_0 = @input.peek( 1 )

            if ( look_40_0 == NL )
              alt_40 = 1

            end
            case alt_40
            when 1
              # at line 284:3: NL
              __NL97__ = match( NL, TOKENS_FOLLOWING_NL_IN_state_dependency_667 )
              tree_for_NL97 = @adaptor.create_with_payload( __NL97__ )
              @adaptor.add_child( root_0, tree_for_NL97 )



            else
              break # out of loop for decision 40
            end
          end # loop for decision 40

          @state.following.push( TOKENS_FOLLOWING_constraint_body_IN_state_dependency_670 )
          constraint_body98 = constraint_body
          @state.following.pop
          @adaptor.add_child( root_0, constraint_body98.tree )

          char_literal99 = match( T__86, TOKENS_FOLLOWING_T__86_IN_state_dependency_674 )
          tree_for_char_literal99 = @adaptor.create_with_payload( char_literal99 )
          @adaptor.add_child( root_0, tree_for_char_literal99 )



        else
          break # out of loop for decision 41
        end
      end # loop for decision 41

      # at file 286:3: ( NL )+
      match_count_42 = 0
      while true
        alt_42 = 2
        look_42_0 = @input.peek( 1 )

        if ( look_42_0 == NL )
          alt_42 = 1

        end
        case alt_42
        when 1
          # at line 286:3: NL
          __NL100__ = match( NL, TOKENS_FOLLOWING_NL_IN_state_dependency_680 )
          tree_for_NL100 = @adaptor.create_with_payload( __NL100__ )
          @adaptor.add_child( root_0, tree_for_NL100 )



        else
          match_count_42 > 0 and break
          eee = EarlyExit(42)


          raise eee
        end
        match_count_42 += 1
      end



      # - - - - - - - rule clean up - - - - - - - -
      return_value.stop = @input.look( -1 )


      return_value.tree = @adaptor.rule_post_processing( root_0 )
      @adaptor.set_token_boundaries( return_value.tree, return_value.start, return_value.stop )


      rescue ANTLR3::Error::RecognitionError => re
        report_error(re)
        recover(re)
        return_value.tree = @adaptor.create_error_node( @input, return_value.start, @input.look(-1), re )


      ensure
        # -> uncomment the next line to manually enable rule tracing
        # trace_out( __method__, 17 )


      end

      return return_value
    end

    DepEffectReturnValue = define_return_scope

    #
    # parser rule dep_effect
    #
    # (in SfpLang.g)
    # 289:1: dep_effect : reference equals_op ( value | NULL ) ;
    #
    def dep_effect
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 18 )


      return_value = DepEffectReturnValue.new

      # $rule.start = the first token seen before matching
      return_value.start = @input.look


      root_0 = nil

      __NULL104__ = nil
      reference101 = nil
      equals_op102 = nil
      value103 = nil


      tree_for_NULL104 = nil

      begin
      root_0 = @adaptor.create_flat_list


      # at line 290:4: reference equals_op ( value | NULL )
      @state.following.push( TOKENS_FOLLOWING_reference_IN_dep_effect_692 )
      reference101 = reference
      @state.following.pop
      @adaptor.add_child( root_0, reference101.tree )

      @state.following.push( TOKENS_FOLLOWING_equals_op_IN_dep_effect_694 )
      equals_op102 = equals_op
      @state.following.pop
      @adaptor.add_child( root_0, equals_op102.tree )

      # at line 291:3: ( value | NULL )
      alt_43 = 2
      look_43_0 = @input.peek( 1 )

      if ( look_43_0 == BOOLEAN || look_43_0.between?( ID, MULTILINE_STRING ) || look_43_0 == NUMBER || look_43_0 == STRING || look_43_0 == T__20 || look_43_0 == T__35 || look_43_0 == T__41 )
        alt_43 = 1
      elsif ( look_43_0 == NULL )
        alt_43 = 2
      else
        raise NoViableAlternative( "", 43, 0 )

      end
      case alt_43
      when 1
        # at line 291:5: value
        @state.following.push( TOKENS_FOLLOWING_value_IN_dep_effect_701 )
        value103 = value
        @state.following.pop
        @adaptor.add_child( root_0, value103.tree )


      when 2
        # at line 292:5: NULL
        __NULL104__ = match( NULL, TOKENS_FOLLOWING_NULL_IN_dep_effect_707 )
        tree_for_NULL104 = @adaptor.create_with_payload( __NULL104__ )
        @adaptor.add_child( root_0, tree_for_NULL104 )



      end

      # - - - - - - - rule clean up - - - - - - - -
      return_value.stop = @input.look( -1 )


      return_value.tree = @adaptor.rule_post_processing( root_0 )
      @adaptor.set_token_boundaries( return_value.tree, return_value.start, return_value.stop )


      rescue ANTLR3::Error::RecognitionError => re
        report_error(re)
        recover(re)
        return_value.tree = @adaptor.create_error_node( @input, return_value.start, @input.look(-1), re )


      ensure
        # -> uncomment the next line to manually enable rule tracing
        # trace_out( __method__, 18 )


      end

      return return_value
    end

    OpParamReturnValue = define_return_scope

    #
    # parser rule op_param
    #
    # (in SfpLang.g)
    # 296:1: op_param : ID equals_op reference ( NL )+ ;
    #
    def op_param
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 19 )


      return_value = OpParamReturnValue.new

      # $rule.start = the first token seen before matching
      return_value.start = @input.look


      root_0 = nil

      __ID105__ = nil
      __NL108__ = nil
      equals_op106 = nil
      reference107 = nil


      tree_for_ID105 = nil
      tree_for_NL108 = nil

      begin
      root_0 = @adaptor.create_flat_list


      # at line 297:4: ID equals_op reference ( NL )+
      __ID105__ = match( ID, TOKENS_FOLLOWING_ID_IN_op_param_723 )
      tree_for_ID105 = @adaptor.create_with_payload( __ID105__ )
      @adaptor.add_child( root_0, tree_for_ID105 )


      @state.following.push( TOKENS_FOLLOWING_equals_op_IN_op_param_725 )
      equals_op106 = equals_op
      @state.following.pop
      @adaptor.add_child( root_0, equals_op106.tree )

      @state.following.push( TOKENS_FOLLOWING_reference_IN_op_param_727 )
      reference107 = reference
      @state.following.pop
      @adaptor.add_child( root_0, reference107.tree )

      # at file 297:27: ( NL )+
      match_count_44 = 0
      while true
        alt_44 = 2
        look_44_0 = @input.peek( 1 )

        if ( look_44_0 == NL )
          alt_44 = 1

        end
        case alt_44
        when 1
          # at line 297:27: NL
          __NL108__ = match( NL, TOKENS_FOLLOWING_NL_IN_op_param_729 )
          tree_for_NL108 = @adaptor.create_with_payload( __NL108__ )
          @adaptor.add_child( root_0, tree_for_NL108 )



        else
          match_count_44 > 0 and break
          eee = EarlyExit(44)


          raise eee
        end
        match_count_44 += 1
      end



      # --> action
      	@now[__ID105__.text] = ( reference107.nil? ? nil : reference107.val )	
      # <-- action


      # - - - - - - - rule clean up - - - - - - - -
      return_value.stop = @input.look( -1 )


      return_value.tree = @adaptor.rule_post_processing( root_0 )
      @adaptor.set_token_boundaries( return_value.tree, return_value.start, return_value.stop )


      rescue ANTLR3::Error::RecognitionError => re
        report_error(re)
        recover(re)
        return_value.tree = @adaptor.create_error_node( @input, return_value.start, @input.look(-1), re )


      ensure
        # -> uncomment the next line to manually enable rule tracing
        # trace_out( __method__, 19 )


      end

      return return_value
    end

    OpConditionsReturnValue = define_return_scope

    #
    # parser rule op_conditions
    #
    # (in SfpLang.g)
    # 301:1: op_conditions : ( 'conditions' | 'condition' ) '{' ( NL )* ( op_statement )* '}' ( NL )+ ;
    #
    def op_conditions
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 20 )


      return_value = OpConditionsReturnValue.new

      # $rule.start = the first token seen before matching
      return_value.start = @input.look


      root_0 = nil

      set109 = nil
      char_literal110 = nil
      __NL111__ = nil
      char_literal113 = nil
      __NL114__ = nil
      op_statement112 = nil


      tree_for_set109 = nil
      tree_for_char_literal110 = nil
      tree_for_NL111 = nil
      tree_for_char_literal113 = nil
      tree_for_NL114 = nil

      begin
      root_0 = @adaptor.create_flat_list


      # at line 302:4: ( 'conditions' | 'condition' ) '{' ( NL )* ( op_statement )* '}' ( NL )+
      set109 = @input.look

      if @input.peek( 1 ).between?( T__46, T__47 )
        @input.consume
        @adaptor.add_child( root_0, @adaptor.create_with_payload( set109 ) )

        @state.error_recovery = false

      else
        mse = MismatchedSet( nil )
        raise mse

      end


      char_literal110 = match( T__85, TOKENS_FOLLOWING_T__85_IN_op_conditions_753 )
      tree_for_char_literal110 = @adaptor.create_with_payload( char_literal110 )
      @adaptor.add_child( root_0, tree_for_char_literal110 )


      # at line 302:37: ( NL )*
      while true # decision 45
        alt_45 = 2
        look_45_0 = @input.peek( 1 )

        if ( look_45_0 == NL )
          alt_45 = 1

        end
        case alt_45
        when 1
          # at line 302:37: NL
          __NL111__ = match( NL, TOKENS_FOLLOWING_NL_IN_op_conditions_755 )
          tree_for_NL111 = @adaptor.create_with_payload( __NL111__ )
          @adaptor.add_child( root_0, tree_for_NL111 )



        else
          break # out of loop for decision 45
        end
      end # loop for decision 45


      # --> action

      			@now['_condition']['_parent'] = @now
      			@now = @now['_condition']
      		
      # <-- action

      # at line 307:3: ( op_statement )*
      while true # decision 46
        alt_46 = 2
        look_46_0 = @input.peek( 1 )

        if ( look_46_0 == ID )
          alt_46 = 1

        end
        case alt_46
        when 1
          # at line 307:3: op_statement
          @state.following.push( TOKENS_FOLLOWING_op_statement_IN_op_conditions_764 )
          op_statement112 = op_statement
          @state.following.pop
          @adaptor.add_child( root_0, op_statement112.tree )


        else
          break # out of loop for decision 46
        end
      end # loop for decision 46

      char_literal113 = match( T__86, TOKENS_FOLLOWING_T__86_IN_op_conditions_769 )
      tree_for_char_literal113 = @adaptor.create_with_payload( char_literal113 )
      @adaptor.add_child( root_0, tree_for_char_literal113 )


      # at file 308:7: ( NL )+
      match_count_47 = 0
      while true
        alt_47 = 2
        look_47_0 = @input.peek( 1 )

        if ( look_47_0 == NL )
          alt_47 = 1

        end
        case alt_47
        when 1
          # at line 308:7: NL
          __NL114__ = match( NL, TOKENS_FOLLOWING_NL_IN_op_conditions_771 )
          tree_for_NL114 = @adaptor.create_with_payload( __NL114__ )
          @adaptor.add_child( root_0, tree_for_NL114 )



        else
          match_count_47 > 0 and break
          eee = EarlyExit(47)


          raise eee
        end
        match_count_47 += 1
      end



      # --> action
      	self.goto_parent()	
      # <-- action


      # - - - - - - - rule clean up - - - - - - - -
      return_value.stop = @input.look( -1 )


      return_value.tree = @adaptor.rule_post_processing( root_0 )
      @adaptor.set_token_boundaries( return_value.tree, return_value.start, return_value.stop )


      rescue ANTLR3::Error::RecognitionError => re
        report_error(re)
        recover(re)
        return_value.tree = @adaptor.create_error_node( @input, return_value.start, @input.look(-1), re )


      ensure
        # -> uncomment the next line to manually enable rule tracing
        # trace_out( __method__, 20 )


      end

      return return_value
    end

    OpEffectsReturnValue = define_return_scope

    #
    # parser rule op_effects
    #
    # (in SfpLang.g)
    # 312:1: op_effects : 'effects' '{' ( NL )* ( op_statement )* '}' ( NL )+ ;
    #
    def op_effects
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 21 )


      return_value = OpEffectsReturnValue.new

      # $rule.start = the first token seen before matching
      return_value.start = @input.look


      root_0 = nil

      string_literal115 = nil
      char_literal116 = nil
      __NL117__ = nil
      char_literal119 = nil
      __NL120__ = nil
      op_statement118 = nil


      tree_for_string_literal115 = nil
      tree_for_char_literal116 = nil
      tree_for_NL117 = nil
      tree_for_char_literal119 = nil
      tree_for_NL120 = nil

      begin
      root_0 = @adaptor.create_flat_list


      # at line 313:4: 'effects' '{' ( NL )* ( op_statement )* '}' ( NL )+
      string_literal115 = match( T__52, TOKENS_FOLLOWING_T__52_IN_op_effects_787 )
      tree_for_string_literal115 = @adaptor.create_with_payload( string_literal115 )
      @adaptor.add_child( root_0, tree_for_string_literal115 )


      char_literal116 = match( T__85, TOKENS_FOLLOWING_T__85_IN_op_effects_789 )
      tree_for_char_literal116 = @adaptor.create_with_payload( char_literal116 )
      @adaptor.add_child( root_0, tree_for_char_literal116 )


      # at line 313:18: ( NL )*
      while true # decision 48
        alt_48 = 2
        look_48_0 = @input.peek( 1 )

        if ( look_48_0 == NL )
          alt_48 = 1

        end
        case alt_48
        when 1
          # at line 313:18: NL
          __NL117__ = match( NL, TOKENS_FOLLOWING_NL_IN_op_effects_791 )
          tree_for_NL117 = @adaptor.create_with_payload( __NL117__ )
          @adaptor.add_child( root_0, tree_for_NL117 )



        else
          break # out of loop for decision 48
        end
      end # loop for decision 48


      # --> action

      			@now['_effect']['_parent'] = @now
      			@now = @now['_effect']
      		
      # <-- action

      # at line 318:3: ( op_statement )*
      while true # decision 49
        alt_49 = 2
        look_49_0 = @input.peek( 1 )

        if ( look_49_0 == ID )
          alt_49 = 1

        end
        case alt_49
        when 1
          # at line 318:3: op_statement
          @state.following.push( TOKENS_FOLLOWING_op_statement_IN_op_effects_800 )
          op_statement118 = op_statement
          @state.following.pop
          @adaptor.add_child( root_0, op_statement118.tree )


        else
          break # out of loop for decision 49
        end
      end # loop for decision 49

      char_literal119 = match( T__86, TOKENS_FOLLOWING_T__86_IN_op_effects_805 )
      tree_for_char_literal119 = @adaptor.create_with_payload( char_literal119 )
      @adaptor.add_child( root_0, tree_for_char_literal119 )


      # at file 319:7: ( NL )+
      match_count_50 = 0
      while true
        alt_50 = 2
        look_50_0 = @input.peek( 1 )

        if ( look_50_0 == NL )
          alt_50 = 1

        end
        case alt_50
        when 1
          # at line 319:7: NL
          __NL120__ = match( NL, TOKENS_FOLLOWING_NL_IN_op_effects_807 )
          tree_for_NL120 = @adaptor.create_with_payload( __NL120__ )
          @adaptor.add_child( root_0, tree_for_NL120 )



        else
          match_count_50 > 0 and break
          eee = EarlyExit(50)


          raise eee
        end
        match_count_50 += 1
      end



      # --> action
      	self.goto_parent()	
      # <-- action


      # - - - - - - - rule clean up - - - - - - - -
      return_value.stop = @input.look( -1 )


      return_value.tree = @adaptor.rule_post_processing( root_0 )
      @adaptor.set_token_boundaries( return_value.tree, return_value.start, return_value.stop )


      rescue ANTLR3::Error::RecognitionError => re
        report_error(re)
        recover(re)
        return_value.tree = @adaptor.create_error_node( @input, return_value.start, @input.look(-1), re )


      ensure
        # -> uncomment the next line to manually enable rule tracing
        # trace_out( __method__, 21 )


      end

      return return_value
    end

    OpStatementReturnValue = define_return_scope

    #
    # parser rule op_statement
    #
    # (in SfpLang.g)
    # 323:1: op_statement : reference equals_op value ( NL )+ ;
    #
    def op_statement
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 22 )


      return_value = OpStatementReturnValue.new

      # $rule.start = the first token seen before matching
      return_value.start = @input.look


      root_0 = nil

      __NL124__ = nil
      reference121 = nil
      equals_op122 = nil
      value123 = nil


      tree_for_NL124 = nil

      begin
      root_0 = @adaptor.create_flat_list


      # at line 324:4: reference equals_op value ( NL )+
      @state.following.push( TOKENS_FOLLOWING_reference_IN_op_statement_823 )
      reference121 = reference
      @state.following.pop
      @adaptor.add_child( root_0, reference121.tree )

      @state.following.push( TOKENS_FOLLOWING_equals_op_IN_op_statement_825 )
      equals_op122 = equals_op
      @state.following.pop
      @adaptor.add_child( root_0, equals_op122.tree )

      @state.following.push( TOKENS_FOLLOWING_value_IN_op_statement_827 )
      value123 = value
      @state.following.pop
      @adaptor.add_child( root_0, value123.tree )

      # at file 324:30: ( NL )+
      match_count_51 = 0
      while true
        alt_51 = 2
        look_51_0 = @input.peek( 1 )

        if ( look_51_0 == NL )
          alt_51 = 1

        end
        case alt_51
        when 1
          # at line 324:30: NL
          __NL124__ = match( NL, TOKENS_FOLLOWING_NL_IN_op_statement_829 )
          tree_for_NL124 = @adaptor.create_with_payload( __NL124__ )
          @adaptor.add_child( root_0, tree_for_NL124 )



        else
          match_count_51 > 0 and break
          eee = EarlyExit(51)


          raise eee
        end
        match_count_51 += 1
      end



      # --> action
      	@now[( reference121.nil? ? nil : reference121.val )] = ( value123.nil? ? nil : value123.val )	
      # <-- action


      # - - - - - - - rule clean up - - - - - - - -
      return_value.stop = @input.look( -1 )


      return_value.tree = @adaptor.rule_post_processing( root_0 )
      @adaptor.set_token_boundaries( return_value.tree, return_value.start, return_value.stop )


      rescue ANTLR3::Error::RecognitionError => re
        report_error(re)
        recover(re)
        return_value.tree = @adaptor.create_error_node( @input, return_value.start, @input.look(-1), re )


      ensure
        # -> uncomment the next line to manually enable rule tracing
        # trace_out( __method__, 22 )


      end

      return return_value
    end

    ProcedureReturnValue = define_return_scope

    #
    # parser rule procedure
    #
    # (in SfpLang.g)
    # 328:1: procedure : ( 'synchronized' )? ( 'procedure' | 'sub' ) ID ( parameters )? '{' ( NL )* ( 'cost' equals_op NUMBER ( NL )+ )? ( conditions )? effects '}' ;
    #
    def procedure
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 23 )


      return_value = ProcedureReturnValue.new

      # $rule.start = the first token seen before matching
      return_value.start = @input.look


      root_0 = nil

      string_literal125 = nil
      set126 = nil
      __ID127__ = nil
      char_literal129 = nil
      __NL130__ = nil
      string_literal131 = nil
      __NUMBER133__ = nil
      __NL134__ = nil
      char_literal137 = nil
      parameters128 = nil
      equals_op132 = nil
      conditions135 = nil
      effects136 = nil


      tree_for_string_literal125 = nil
      tree_for_set126 = nil
      tree_for_ID127 = nil
      tree_for_char_literal129 = nil
      tree_for_NL130 = nil
      tree_for_string_literal131 = nil
      tree_for_NUMBER133 = nil
      tree_for_NL134 = nil
      tree_for_char_literal137 = nil

      begin
      root_0 = @adaptor.create_flat_list


      # at line 329:4: ( 'synchronized' )? ( 'procedure' | 'sub' ) ID ( parameters )? '{' ( NL )* ( 'cost' equals_op NUMBER ( NL )+ )? ( conditions )? effects '}'
      # --> action
        @synchronized = false  
      # <-- action

      # at line 330:3: ( 'synchronized' )?
      alt_52 = 2
      look_52_0 = @input.peek( 1 )

      if ( look_52_0 == T__81 )
        alt_52 = 1
      end
      case alt_52
      when 1
        # at line 330:4: 'synchronized'
        string_literal125 = match( T__81, TOKENS_FOLLOWING_T__81_IN_procedure_850 )
        tree_for_string_literal125 = @adaptor.create_with_payload( string_literal125 )
        @adaptor.add_child( root_0, tree_for_string_literal125 )



        # --> action
         @synchronized = true 
        # <-- action


      end

      set126 = @input.look

      if @input.peek(1) == T__75 || @input.peek(1) == T__80
        @input.consume
        @adaptor.add_child( root_0, @adaptor.create_with_payload( set126 ) )

        @state.error_recovery = false

      else
        mse = MismatchedSet( nil )
        raise mse

      end


      __ID127__ = match( ID, TOKENS_FOLLOWING_ID_IN_procedure_864 )
      tree_for_ID127 = @adaptor.create_with_payload( __ID127__ )
      @adaptor.add_child( root_0, tree_for_ID127 )



      # --> action

      			@now[__ID127__.text] = { '_self' => __ID127__.text,
      				'_context' => 'procedure',
      				'_parent' => @now,
      				'_cost' => 1,
      				'_condition' => { '_context' => 'constraint', '_type' => 'and' },
      				'_effect' => { '_context' => 'effect', '_type' => 'and' },
      				'_synchronized' => @synchronized,
      			}
      			@now = @now[__ID127__.text]
      		
      # <-- action

      # at line 343:3: ( parameters )?
      alt_53 = 2
      look_53_0 = @input.peek( 1 )

      if ( look_53_0 == T__20 )
        alt_53 = 1
      end
      case alt_53
      when 1
        # at line 343:3: parameters
        @state.following.push( TOKENS_FOLLOWING_parameters_IN_procedure_872 )
        parameters128 = parameters
        @state.following.pop
        @adaptor.add_child( root_0, parameters128.tree )


      end
      char_literal129 = match( T__85, TOKENS_FOLLOWING_T__85_IN_procedure_875 )
      tree_for_char_literal129 = @adaptor.create_with_payload( char_literal129 )
      @adaptor.add_child( root_0, tree_for_char_literal129 )


      # at line 343:19: ( NL )*
      while true # decision 54
        alt_54 = 2
        look_54_0 = @input.peek( 1 )

        if ( look_54_0 == NL )
          alt_54 = 1

        end
        case alt_54
        when 1
          # at line 343:19: NL
          __NL130__ = match( NL, TOKENS_FOLLOWING_NL_IN_procedure_877 )
          tree_for_NL130 = @adaptor.create_with_payload( __NL130__ )
          @adaptor.add_child( root_0, tree_for_NL130 )



        else
          break # out of loop for decision 54
        end
      end # loop for decision 54

      # at line 344:3: ( 'cost' equals_op NUMBER ( NL )+ )?
      alt_56 = 2
      look_56_0 = @input.peek( 1 )

      if ( look_56_0 == T__49 )
        alt_56 = 1
      end
      case alt_56
      when 1
        # at line 344:5: 'cost' equals_op NUMBER ( NL )+
        string_literal131 = match( T__49, TOKENS_FOLLOWING_T__49_IN_procedure_885 )
        tree_for_string_literal131 = @adaptor.create_with_payload( string_literal131 )
        @adaptor.add_child( root_0, tree_for_string_literal131 )


        @state.following.push( TOKENS_FOLLOWING_equals_op_IN_procedure_887 )
        equals_op132 = equals_op
        @state.following.pop
        @adaptor.add_child( root_0, equals_op132.tree )

        __NUMBER133__ = match( NUMBER, TOKENS_FOLLOWING_NUMBER_IN_procedure_889 )
        tree_for_NUMBER133 = @adaptor.create_with_payload( __NUMBER133__ )
        @adaptor.add_child( root_0, tree_for_NUMBER133 )



        # --> action
        	@now['_cost'] = __NUMBER133__.text.to_i	
        # <-- action

        # at file 346:4: ( NL )+
        match_count_55 = 0
        while true
          alt_55 = 2
          look_55_0 = @input.peek( 1 )

          if ( look_55_0 == NL )
            alt_55 = 1

          end
          case alt_55
          when 1
            # at line 346:4: NL
            __NL134__ = match( NL, TOKENS_FOLLOWING_NL_IN_procedure_899 )
            tree_for_NL134 = @adaptor.create_with_payload( __NL134__ )
            @adaptor.add_child( root_0, tree_for_NL134 )



          else
            match_count_55 > 0 and break
            eee = EarlyExit(55)


            raise eee
          end
          match_count_55 += 1
        end



      end
      # at line 348:3: ( conditions )?
      alt_57 = 2
      look_57_0 = @input.peek( 1 )

      if ( look_57_0.between?( T__46, T__47 ) )
        alt_57 = 1
      end
      case alt_57
      when 1
        # at line 348:3: conditions
        @state.following.push( TOKENS_FOLLOWING_conditions_IN_procedure_909 )
        conditions135 = conditions
        @state.following.pop
        @adaptor.add_child( root_0, conditions135.tree )


      end
      @state.following.push( TOKENS_FOLLOWING_effects_IN_procedure_912 )
      effects136 = effects
      @state.following.pop
      @adaptor.add_child( root_0, effects136.tree )

      char_literal137 = match( T__86, TOKENS_FOLLOWING_T__86_IN_procedure_914 )
      tree_for_char_literal137 = @adaptor.create_with_payload( char_literal137 )
      @adaptor.add_child( root_0, tree_for_char_literal137 )



      # --> action
      	self.goto_parent()	
      # <-- action


      # - - - - - - - rule clean up - - - - - - - -
      return_value.stop = @input.look( -1 )


      return_value.tree = @adaptor.rule_post_processing( root_0 )
      @adaptor.set_token_boundaries( return_value.tree, return_value.start, return_value.stop )


      rescue ANTLR3::Error::RecognitionError => re
        report_error(re)
        recover(re)
        return_value.tree = @adaptor.create_error_node( @input, return_value.start, @input.look(-1), re )


      ensure
        # -> uncomment the next line to manually enable rule tracing
        # trace_out( __method__, 23 )


      end

      return return_value
    end

    ParametersReturnValue = define_return_scope

    #
    # parser rule parameters
    #
    # (in SfpLang.g)
    # 352:1: parameters : '(' parameter ( ',' ( NL )* parameter )* ')' ;
    #
    def parameters
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 24 )


      return_value = ParametersReturnValue.new

      # $rule.start = the first token seen before matching
      return_value.start = @input.look


      root_0 = nil

      char_literal138 = nil
      char_literal140 = nil
      __NL141__ = nil
      char_literal143 = nil
      parameter139 = nil
      parameter142 = nil


      tree_for_char_literal138 = nil
      tree_for_char_literal140 = nil
      tree_for_NL141 = nil
      tree_for_char_literal143 = nil

      begin
      root_0 = @adaptor.create_flat_list


      # at line 353:4: '(' parameter ( ',' ( NL )* parameter )* ')'
      char_literal138 = match( T__20, TOKENS_FOLLOWING_T__20_IN_parameters_929 )
      tree_for_char_literal138 = @adaptor.create_with_payload( char_literal138 )
      @adaptor.add_child( root_0, tree_for_char_literal138 )


      @state.following.push( TOKENS_FOLLOWING_parameter_IN_parameters_931 )
      parameter139 = parameter
      @state.following.pop
      @adaptor.add_child( root_0, parameter139.tree )

      # at line 353:18: ( ',' ( NL )* parameter )*
      while true # decision 59
        alt_59 = 2
        look_59_0 = @input.peek( 1 )

        if ( look_59_0 == T__24 )
          alt_59 = 1

        end
        case alt_59
        when 1
          # at line 353:19: ',' ( NL )* parameter
          char_literal140 = match( T__24, TOKENS_FOLLOWING_T__24_IN_parameters_934 )
          tree_for_char_literal140 = @adaptor.create_with_payload( char_literal140 )
          @adaptor.add_child( root_0, tree_for_char_literal140 )


          # at line 353:23: ( NL )*
          while true # decision 58
            alt_58 = 2
            look_58_0 = @input.peek( 1 )

            if ( look_58_0 == NL )
              alt_58 = 1

            end
            case alt_58
            when 1
              # at line 353:23: NL
              __NL141__ = match( NL, TOKENS_FOLLOWING_NL_IN_parameters_936 )
              tree_for_NL141 = @adaptor.create_with_payload( __NL141__ )
              @adaptor.add_child( root_0, tree_for_NL141 )



            else
              break # out of loop for decision 58
            end
          end # loop for decision 58

          @state.following.push( TOKENS_FOLLOWING_parameter_IN_parameters_939 )
          parameter142 = parameter
          @state.following.pop
          @adaptor.add_child( root_0, parameter142.tree )


        else
          break # out of loop for decision 59
        end
      end # loop for decision 59

      char_literal143 = match( T__21, TOKENS_FOLLOWING_T__21_IN_parameters_943 )
      tree_for_char_literal143 = @adaptor.create_with_payload( char_literal143 )
      @adaptor.add_child( root_0, tree_for_char_literal143 )



      # - - - - - - - rule clean up - - - - - - - -
      return_value.stop = @input.look( -1 )


      return_value.tree = @adaptor.rule_post_processing( root_0 )
      @adaptor.set_token_boundaries( return_value.tree, return_value.start, return_value.stop )


      rescue ANTLR3::Error::RecognitionError => re
        report_error(re)
        recover(re)
        return_value.tree = @adaptor.create_error_node( @input, return_value.start, @input.look(-1), re )


      ensure
        # -> uncomment the next line to manually enable rule tracing
        # trace_out( __method__, 24 )


      end

      return return_value
    end

    ParameterReturnValue = define_return_scope

    #
    # parser rule parameter
    #
    # (in SfpLang.g)
    # 356:1: parameter : ( ID ':' path | ID reference_type | ID 'areall' path | ID 'isset' path );
    #
    def parameter
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 25 )


      return_value = ParameterReturnValue.new

      # $rule.start = the first token seen before matching
      return_value.start = @input.look


      root_0 = nil

      __ID144__ = nil
      char_literal145 = nil
      __ID147__ = nil
      __ID149__ = nil
      string_literal150 = nil
      __ID152__ = nil
      string_literal153 = nil
      path146 = nil
      reference_type148 = nil
      path151 = nil
      path154 = nil


      tree_for_ID144 = nil
      tree_for_char_literal145 = nil
      tree_for_ID147 = nil
      tree_for_ID149 = nil
      tree_for_string_literal150 = nil
      tree_for_ID152 = nil
      tree_for_string_literal153 = nil

      begin
      # at line 357:2: ( ID ':' path | ID reference_type | ID 'areall' path | ID 'isset' path )
      alt_60 = 4
      look_60_0 = @input.peek( 1 )

      if ( look_60_0 == ID )
        case look_60 = @input.peek( 2 )
        when T__28 then alt_60 = 1
        when T__42 then alt_60 = 3
        when T__71 then alt_60 = 4
        when T__70 then alt_60 = 2
        else
          raise NoViableAlternative( "", 60, 1 )

        end
      else
        raise NoViableAlternative( "", 60, 0 )

      end
      case alt_60
      when 1
        root_0 = @adaptor.create_flat_list


        # at line 357:4: ID ':' path
        __ID144__ = match( ID, TOKENS_FOLLOWING_ID_IN_parameter_955 )
        tree_for_ID144 = @adaptor.create_with_payload( __ID144__ )
        @adaptor.add_child( root_0, tree_for_ID144 )


        char_literal145 = match( T__28, TOKENS_FOLLOWING_T__28_IN_parameter_957 )
        tree_for_char_literal145 = @adaptor.create_with_payload( char_literal145 )
        @adaptor.add_child( root_0, tree_for_char_literal145 )


        @state.following.push( TOKENS_FOLLOWING_path_IN_parameter_959 )
        path146 = path
        @state.following.pop
        @adaptor.add_child( root_0, path146.tree )


        # --> action

        			@now[__ID144__.text] = { '_context' => 'any_value',
        				'_isa' => self.to_ref(( path146 && @input.to_s( path146.start, path146.stop ) ))
        			}
        		
        # <-- action


      when 2
        root_0 = @adaptor.create_flat_list


        # at line 363:4: ID reference_type
        __ID147__ = match( ID, TOKENS_FOLLOWING_ID_IN_parameter_968 )
        tree_for_ID147 = @adaptor.create_with_payload( __ID147__ )
        @adaptor.add_child( root_0, tree_for_ID147 )


        @state.following.push( TOKENS_FOLLOWING_reference_type_IN_parameter_970 )
        reference_type148 = reference_type
        @state.following.pop
        @adaptor.add_child( root_0, reference_type148.tree )


        # --> action
        	@now[__ID147__.text] = ( reference_type148.nil? ? nil : reference_type148.val )	
        # <-- action


      when 3
        root_0 = @adaptor.create_flat_list


        # at line 365:4: ID 'areall' path
        __ID149__ = match( ID, TOKENS_FOLLOWING_ID_IN_parameter_979 )
        tree_for_ID149 = @adaptor.create_with_payload( __ID149__ )
        @adaptor.add_child( root_0, tree_for_ID149 )


        string_literal150 = match( T__42, TOKENS_FOLLOWING_T__42_IN_parameter_981 )
        tree_for_string_literal150 = @adaptor.create_with_payload( string_literal150 )
        @adaptor.add_child( root_0, tree_for_string_literal150 )


        @state.following.push( TOKENS_FOLLOWING_path_IN_parameter_983 )
        path151 = path
        @state.following.pop
        @adaptor.add_child( root_0, path151.tree )


        # --> action

        			@now[__ID149__.text] = { '_context' => 'all',
        				'_isa' => self.to_ref(( path151 && @input.to_s( path151.start, path151.stop ) )),
        				'_value' => nil
        			}
        		
        # <-- action


      when 4
        root_0 = @adaptor.create_flat_list


        # at line 372:4: ID 'isset' path
        __ID152__ = match( ID, TOKENS_FOLLOWING_ID_IN_parameter_992 )
        tree_for_ID152 = @adaptor.create_with_payload( __ID152__ )
        @adaptor.add_child( root_0, tree_for_ID152 )


        string_literal153 = match( T__71, TOKENS_FOLLOWING_T__71_IN_parameter_994 )
        tree_for_string_literal153 = @adaptor.create_with_payload( string_literal153 )
        @adaptor.add_child( root_0, tree_for_string_literal153 )


        @state.following.push( TOKENS_FOLLOWING_path_IN_parameter_996 )
        path154 = path
        @state.following.pop
        @adaptor.add_child( root_0, path154.tree )


        # --> action

        			@now[__ID152__.text] = { '_context' => 'set',
        				'_isa' => self.to_ref(( path154 && @input.to_s( path154.start, path154.stop ) )),
        				'_values' => []
        			}
        		
        # <-- action


      end
      # - - - - - - - rule clean up - - - - - - - -
      return_value.stop = @input.look( -1 )


      return_value.tree = @adaptor.rule_post_processing( root_0 )
      @adaptor.set_token_boundaries( return_value.tree, return_value.start, return_value.stop )


      rescue ANTLR3::Error::RecognitionError => re
        report_error(re)
        recover(re)
        return_value.tree = @adaptor.create_error_node( @input, return_value.start, @input.look(-1), re )


      ensure
        # -> uncomment the next line to manually enable rule tracing
        # trace_out( __method__, 25 )


      end

      return return_value
    end

    ConditionsReturnValue = define_return_scope

    #
    # parser rule conditions
    #
    # (in SfpLang.g)
    # 381:1: conditions : ( 'conditions' | 'condition' ) '{' ( NL )* constraint_body '}' ( NL )+ ;
    #
    def conditions
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 26 )


      return_value = ConditionsReturnValue.new

      # $rule.start = the first token seen before matching
      return_value.start = @input.look


      root_0 = nil

      set155 = nil
      char_literal156 = nil
      __NL157__ = nil
      char_literal159 = nil
      __NL160__ = nil
      constraint_body158 = nil


      tree_for_set155 = nil
      tree_for_char_literal156 = nil
      tree_for_NL157 = nil
      tree_for_char_literal159 = nil
      tree_for_NL160 = nil

      begin
      root_0 = @adaptor.create_flat_list


      # at line 382:4: ( 'conditions' | 'condition' ) '{' ( NL )* constraint_body '}' ( NL )+
      set155 = @input.look

      if @input.peek( 1 ).between?( T__46, T__47 )
        @input.consume
        @adaptor.add_child( root_0, @adaptor.create_with_payload( set155 ) )

        @state.error_recovery = false

      else
        mse = MismatchedSet( nil )
        raise mse

      end



      # --> action

      			@now['_condition']['_parent'] = @now
      			@now = @now['_condition']
      		
      # <-- action

      char_literal156 = match( T__85, TOKENS_FOLLOWING_T__85_IN_conditions_1025 )
      tree_for_char_literal156 = @adaptor.create_with_payload( char_literal156 )
      @adaptor.add_child( root_0, tree_for_char_literal156 )


      # at line 387:7: ( NL )*
      while true # decision 61
        alt_61 = 2
        look_61_0 = @input.peek( 1 )

        if ( look_61_0 == NL )
          alt_61 = 1

        end
        case alt_61
        when 1
          # at line 387:7: NL
          __NL157__ = match( NL, TOKENS_FOLLOWING_NL_IN_conditions_1027 )
          tree_for_NL157 = @adaptor.create_with_payload( __NL157__ )
          @adaptor.add_child( root_0, tree_for_NL157 )



        else
          break # out of loop for decision 61
        end
      end # loop for decision 61

      @state.following.push( TOKENS_FOLLOWING_constraint_body_IN_conditions_1030 )
      constraint_body158 = constraint_body
      @state.following.pop
      @adaptor.add_child( root_0, constraint_body158.tree )

      char_literal159 = match( T__86, TOKENS_FOLLOWING_T__86_IN_conditions_1032 )
      tree_for_char_literal159 = @adaptor.create_with_payload( char_literal159 )
      @adaptor.add_child( root_0, tree_for_char_literal159 )


      # at file 387:31: ( NL )+
      match_count_62 = 0
      while true
        alt_62 = 2
        look_62_0 = @input.peek( 1 )

        if ( look_62_0 == NL )
          alt_62 = 1

        end
        case alt_62
        when 1
          # at line 387:31: NL
          __NL160__ = match( NL, TOKENS_FOLLOWING_NL_IN_conditions_1034 )
          tree_for_NL160 = @adaptor.create_with_payload( __NL160__ )
          @adaptor.add_child( root_0, tree_for_NL160 )



        else
          match_count_62 > 0 and break
          eee = EarlyExit(62)


          raise eee
        end
        match_count_62 += 1
      end



      # --> action
      	self.goto_parent()	
      # <-- action


      # - - - - - - - rule clean up - - - - - - - -
      return_value.stop = @input.look( -1 )


      return_value.tree = @adaptor.rule_post_processing( root_0 )
      @adaptor.set_token_boundaries( return_value.tree, return_value.start, return_value.stop )


      rescue ANTLR3::Error::RecognitionError => re
        report_error(re)
        recover(re)
        return_value.tree = @adaptor.create_error_node( @input, return_value.start, @input.look(-1), re )


      ensure
        # -> uncomment the next line to manually enable rule tracing
        # trace_out( __method__, 26 )


      end

      return return_value
    end

    EffectsReturnValue = define_return_scope

    #
    # parser rule effects
    #
    # (in SfpLang.g)
    # 392:1: effects : ( 'effects' | 'effect' ) '{' ( NL )* effect_body '}' ( NL )+ ;
    #
    def effects
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 27 )


      return_value = EffectsReturnValue.new

      # $rule.start = the first token seen before matching
      return_value.start = @input.look


      root_0 = nil

      set161 = nil
      char_literal162 = nil
      __NL163__ = nil
      char_literal165 = nil
      __NL166__ = nil
      effect_body164 = nil


      tree_for_set161 = nil
      tree_for_char_literal162 = nil
      tree_for_NL163 = nil
      tree_for_char_literal165 = nil
      tree_for_NL166 = nil

      begin
      root_0 = @adaptor.create_flat_list


      # at line 393:4: ( 'effects' | 'effect' ) '{' ( NL )* effect_body '}' ( NL )+
      set161 = @input.look

      if @input.peek( 1 ).between?( T__51, T__52 )
        @input.consume
        @adaptor.add_child( root_0, @adaptor.create_with_payload( set161 ) )

        @state.error_recovery = false

      else
        mse = MismatchedSet( nil )
        raise mse

      end



      # --> action

      			@now['_effect']['_parent'] = @now
      			@now = @now['_effect']
      			@in_effects = true
      		
      # <-- action

      char_literal162 = match( T__85, TOKENS_FOLLOWING_T__85_IN_effects_1065 )
      tree_for_char_literal162 = @adaptor.create_with_payload( char_literal162 )
      @adaptor.add_child( root_0, tree_for_char_literal162 )


      # at line 399:7: ( NL )*
      while true # decision 63
        alt_63 = 2
        look_63_0 = @input.peek( 1 )

        if ( look_63_0 == NL )
          alt_63 = 1

        end
        case alt_63
        when 1
          # at line 399:7: NL
          __NL163__ = match( NL, TOKENS_FOLLOWING_NL_IN_effects_1067 )
          tree_for_NL163 = @adaptor.create_with_payload( __NL163__ )
          @adaptor.add_child( root_0, tree_for_NL163 )



        else
          break # out of loop for decision 63
        end
      end # loop for decision 63

      @state.following.push( TOKENS_FOLLOWING_effect_body_IN_effects_1073 )
      effect_body164 = effect_body
      @state.following.pop
      @adaptor.add_child( root_0, effect_body164.tree )

      char_literal165 = match( T__86, TOKENS_FOLLOWING_T__86_IN_effects_1078 )
      tree_for_char_literal165 = @adaptor.create_with_payload( char_literal165 )
      @adaptor.add_child( root_0, tree_for_char_literal165 )


      # at file 401:7: ( NL )+
      match_count_64 = 0
      while true
        alt_64 = 2
        look_64_0 = @input.peek( 1 )

        if ( look_64_0 == NL )
          alt_64 = 1

        end
        case alt_64
        when 1
          # at line 401:7: NL
          __NL166__ = match( NL, TOKENS_FOLLOWING_NL_IN_effects_1080 )
          tree_for_NL166 = @adaptor.create_with_payload( __NL166__ )
          @adaptor.add_child( root_0, tree_for_NL166 )



        else
          match_count_64 > 0 and break
          eee = EarlyExit(64)


          raise eee
        end
        match_count_64 += 1
      end



      # --> action

      			self.goto_parent()
      			@in_effects = false
      		
      # <-- action


      # - - - - - - - rule clean up - - - - - - - -
      return_value.stop = @input.look( -1 )


      return_value.tree = @adaptor.rule_post_processing( root_0 )
      @adaptor.set_token_boundaries( return_value.tree, return_value.start, return_value.stop )


      rescue ANTLR3::Error::RecognitionError => re
        report_error(re)
        recover(re)
        return_value.tree = @adaptor.create_error_node( @input, return_value.start, @input.look(-1), re )


      ensure
        # -> uncomment the next line to manually enable rule tracing
        # trace_out( __method__, 27 )


      end

      return return_value
    end

    GoalConstraintReturnValue = define_return_scope

    #
    # parser rule goal_constraint
    #
    # (in SfpLang.g)
    # 408:1: goal_constraint : 'goal' ( 'constraint' )? ( NL )* '{' ( NL )* ( goal_body )* '}' ;
    #
    def goal_constraint
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 28 )


      return_value = GoalConstraintReturnValue.new

      # $rule.start = the first token seen before matching
      return_value.start = @input.look


      root_0 = nil

      string_literal167 = nil
      string_literal168 = nil
      __NL169__ = nil
      char_literal170 = nil
      __NL171__ = nil
      char_literal173 = nil
      goal_body172 = nil


      tree_for_string_literal167 = nil
      tree_for_string_literal168 = nil
      tree_for_NL169 = nil
      tree_for_char_literal170 = nil
      tree_for_NL171 = nil
      tree_for_char_literal173 = nil

      begin
      root_0 = @adaptor.create_flat_list


      # at line 409:4: 'goal' ( 'constraint' )? ( NL )* '{' ( NL )* ( goal_body )* '}'
      string_literal167 = match( T__61, TOKENS_FOLLOWING_T__61_IN_goal_constraint_1096 )
      tree_for_string_literal167 = @adaptor.create_with_payload( string_literal167 )
      @adaptor.add_child( root_0, tree_for_string_literal167 )


      # at line 409:11: ( 'constraint' )?
      alt_65 = 2
      look_65_0 = @input.peek( 1 )

      if ( look_65_0 == T__48 )
        alt_65 = 1
      end
      case alt_65
      when 1
        # at line 409:11: 'constraint'
        string_literal168 = match( T__48, TOKENS_FOLLOWING_T__48_IN_goal_constraint_1098 )
        tree_for_string_literal168 = @adaptor.create_with_payload( string_literal168 )
        @adaptor.add_child( root_0, tree_for_string_literal168 )



      end
      # at line 409:25: ( NL )*
      while true # decision 66
        alt_66 = 2
        look_66_0 = @input.peek( 1 )

        if ( look_66_0 == NL )
          alt_66 = 1

        end
        case alt_66
        when 1
          # at line 409:25: NL
          __NL169__ = match( NL, TOKENS_FOLLOWING_NL_IN_goal_constraint_1101 )
          tree_for_NL169 = @adaptor.create_with_payload( __NL169__ )
          @adaptor.add_child( root_0, tree_for_NL169 )



        else
          break # out of loop for decision 66
        end
      end # loop for decision 66


      # --> action

      			@now['goal'] = { '_self' => 'goal',
      				'_context' => 'constraint',
      				'_type' => 'and',
      				'_parent' => @now
      			}
      			@now = @now['goal']
      		
      # <-- action

      char_literal170 = match( T__85, TOKENS_FOLLOWING_T__85_IN_goal_constraint_1110 )
      tree_for_char_literal170 = @adaptor.create_with_payload( char_literal170 )
      @adaptor.add_child( root_0, tree_for_char_literal170 )


      # at line 418:7: ( NL )*
      while true # decision 67
        alt_67 = 2
        look_67_0 = @input.peek( 1 )

        if ( look_67_0 == NL )
          alt_67 = 1

        end
        case alt_67
        when 1
          # at line 418:7: NL
          __NL171__ = match( NL, TOKENS_FOLLOWING_NL_IN_goal_constraint_1112 )
          tree_for_NL171 = @adaptor.create_with_payload( __NL171__ )
          @adaptor.add_child( root_0, tree_for_NL171 )



        else
          break # out of loop for decision 67
        end
      end # loop for decision 67

      # at line 418:11: ( goal_body )*
      while true # decision 68
        alt_68 = 2
        look_68_0 = @input.peek( 1 )

        if ( look_68_0 == ID || look_68_0.between?( T__39, T__40 ) || look_68_0 == T__44 || look_68_0 == T__54 || look_68_0.between?( T__57, T__60 ) || look_68_0 == T__63 || look_68_0 == T__73 || look_68_0 == T__78 || look_68_0.between?( T__83, T__84 ) )
          alt_68 = 1

        end
        case alt_68
        when 1
          # at line 418:11: goal_body
          @state.following.push( TOKENS_FOLLOWING_goal_body_IN_goal_constraint_1115 )
          goal_body172 = goal_body
          @state.following.pop
          @adaptor.add_child( root_0, goal_body172.tree )


        else
          break # out of loop for decision 68
        end
      end # loop for decision 68

      char_literal173 = match( T__86, TOKENS_FOLLOWING_T__86_IN_goal_constraint_1118 )
      tree_for_char_literal173 = @adaptor.create_with_payload( char_literal173 )
      @adaptor.add_child( root_0, tree_for_char_literal173 )



      # --> action
      	self.goto_parent()	
      # <-- action


      # - - - - - - - rule clean up - - - - - - - -
      return_value.stop = @input.look( -1 )


      return_value.tree = @adaptor.rule_post_processing( root_0 )
      @adaptor.set_token_boundaries( return_value.tree, return_value.start, return_value.stop )


      rescue ANTLR3::Error::RecognitionError => re
        report_error(re)
        recover(re)
        return_value.tree = @adaptor.create_error_node( @input, return_value.start, @input.look(-1), re )


      ensure
        # -> uncomment the next line to manually enable rule tracing
        # trace_out( __method__, 28 )


      end

      return return_value
    end

    GlobalConstraintReturnValue = define_return_scope

    #
    # parser rule global_constraint
    #
    # (in SfpLang.g)
    # 422:1: global_constraint : ( 'global' | 'always' ) ( 'constraint' )? ( NL )* '{' ( NL )* constraint_body '}' ;
    #
    def global_constraint
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 29 )


      return_value = GlobalConstraintReturnValue.new

      # $rule.start = the first token seen before matching
      return_value.start = @input.look


      root_0 = nil

      set174 = nil
      string_literal175 = nil
      __NL176__ = nil
      char_literal177 = nil
      __NL178__ = nil
      char_literal180 = nil
      constraint_body179 = nil


      tree_for_set174 = nil
      tree_for_string_literal175 = nil
      tree_for_NL176 = nil
      tree_for_char_literal177 = nil
      tree_for_NL178 = nil
      tree_for_char_literal180 = nil

      begin
      root_0 = @adaptor.create_flat_list


      # at line 423:4: ( 'global' | 'always' ) ( 'constraint' )? ( NL )* '{' ( NL )* constraint_body '}'
      set174 = @input.look

      if @input.peek(1) == T__40 || @input.peek(1) == T__60
        @input.consume
        @adaptor.add_child( root_0, @adaptor.create_with_payload( set174 ) )

        @state.error_recovery = false

      else
        mse = MismatchedSet( nil )
        raise mse

      end


      # at line 423:24: ( 'constraint' )?
      alt_69 = 2
      look_69_0 = @input.peek( 1 )

      if ( look_69_0 == T__48 )
        alt_69 = 1
      end
      case alt_69
      when 1
        # at line 423:24: 'constraint'
        string_literal175 = match( T__48, TOKENS_FOLLOWING_T__48_IN_global_constraint_1139 )
        tree_for_string_literal175 = @adaptor.create_with_payload( string_literal175 )
        @adaptor.add_child( root_0, tree_for_string_literal175 )



      end
      # at line 423:38: ( NL )*
      while true # decision 70
        alt_70 = 2
        look_70_0 = @input.peek( 1 )

        if ( look_70_0 == NL )
          alt_70 = 1

        end
        case alt_70
        when 1
          # at line 423:38: NL
          __NL176__ = match( NL, TOKENS_FOLLOWING_NL_IN_global_constraint_1142 )
          tree_for_NL176 = @adaptor.create_with_payload( __NL176__ )
          @adaptor.add_child( root_0, tree_for_NL176 )



        else
          break # out of loop for decision 70
        end
      end # loop for decision 70


      # --> action

      			@now['global'] = self.create_constraint('global', 'and') if !@now.has_key?('global')
      			@now = @now['global']
      		
      # <-- action

      char_literal177 = match( T__85, TOKENS_FOLLOWING_T__85_IN_global_constraint_1151 )
      tree_for_char_literal177 = @adaptor.create_with_payload( char_literal177 )
      @adaptor.add_child( root_0, tree_for_char_literal177 )


      # at line 428:7: ( NL )*
      while true # decision 71
        alt_71 = 2
        look_71_0 = @input.peek( 1 )

        if ( look_71_0 == NL )
          alt_71 = 1

        end
        case alt_71
        when 1
          # at line 428:7: NL
          __NL178__ = match( NL, TOKENS_FOLLOWING_NL_IN_global_constraint_1153 )
          tree_for_NL178 = @adaptor.create_with_payload( __NL178__ )
          @adaptor.add_child( root_0, tree_for_NL178 )



        else
          break # out of loop for decision 71
        end
      end # loop for decision 71

      @state.following.push( TOKENS_FOLLOWING_constraint_body_IN_global_constraint_1156 )
      constraint_body179 = constraint_body
      @state.following.pop
      @adaptor.add_child( root_0, constraint_body179.tree )

      char_literal180 = match( T__86, TOKENS_FOLLOWING_T__86_IN_global_constraint_1158 )
      tree_for_char_literal180 = @adaptor.create_with_payload( char_literal180 )
      @adaptor.add_child( root_0, tree_for_char_literal180 )



      # --> action
      	self.goto_parent()	
      # <-- action


      # - - - - - - - rule clean up - - - - - - - -
      return_value.stop = @input.look( -1 )


      return_value.tree = @adaptor.rule_post_processing( root_0 )
      @adaptor.set_token_boundaries( return_value.tree, return_value.start, return_value.stop )


      rescue ANTLR3::Error::RecognitionError => re
        report_error(re)
        recover(re)
        return_value.tree = @adaptor.create_error_node( @input, return_value.start, @input.look(-1), re )


      ensure
        # -> uncomment the next line to manually enable rule tracing
        # trace_out( __method__, 29 )


      end

      return return_value
    end

    SometimeConstraintReturnValue = define_return_scope

    #
    # parser rule sometime_constraint
    #
    # (in SfpLang.g)
    # 432:1: sometime_constraint : 'sometime' ( 'constraint' )? ( NL )* '{' ( NL )* constraint_body '}' ;
    #
    def sometime_constraint
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 30 )


      return_value = SometimeConstraintReturnValue.new

      # $rule.start = the first token seen before matching
      return_value.start = @input.look


      root_0 = nil

      string_literal181 = nil
      string_literal182 = nil
      __NL183__ = nil
      char_literal184 = nil
      __NL185__ = nil
      char_literal187 = nil
      constraint_body186 = nil


      tree_for_string_literal181 = nil
      tree_for_string_literal182 = nil
      tree_for_NL183 = nil
      tree_for_char_literal184 = nil
      tree_for_NL185 = nil
      tree_for_char_literal187 = nil

      begin
      root_0 = @adaptor.create_flat_list


      # at line 433:4: 'sometime' ( 'constraint' )? ( NL )* '{' ( NL )* constraint_body '}'
      string_literal181 = match( T__78, TOKENS_FOLLOWING_T__78_IN_sometime_constraint_1173 )
      tree_for_string_literal181 = @adaptor.create_with_payload( string_literal181 )
      @adaptor.add_child( root_0, tree_for_string_literal181 )


      # at line 433:15: ( 'constraint' )?
      alt_72 = 2
      look_72_0 = @input.peek( 1 )

      if ( look_72_0 == T__48 )
        alt_72 = 1
      end
      case alt_72
      when 1
        # at line 433:15: 'constraint'
        string_literal182 = match( T__48, TOKENS_FOLLOWING_T__48_IN_sometime_constraint_1175 )
        tree_for_string_literal182 = @adaptor.create_with_payload( string_literal182 )
        @adaptor.add_child( root_0, tree_for_string_literal182 )



      end
      # at line 433:29: ( NL )*
      while true # decision 73
        alt_73 = 2
        look_73_0 = @input.peek( 1 )

        if ( look_73_0 == NL )
          alt_73 = 1

        end
        case alt_73
        when 1
          # at line 433:29: NL
          __NL183__ = match( NL, TOKENS_FOLLOWING_NL_IN_sometime_constraint_1178 )
          tree_for_NL183 = @adaptor.create_with_payload( __NL183__ )
          @adaptor.add_child( root_0, tree_for_NL183 )



        else
          break # out of loop for decision 73
        end
      end # loop for decision 73


      # --> action

      			@now['sometime'] = self.create_constraint('sometime', 'or') if !@now.has_key?('sometime')
      			@now = @now['sometime']
      		
      # <-- action

      char_literal184 = match( T__85, TOKENS_FOLLOWING_T__85_IN_sometime_constraint_1187 )
      tree_for_char_literal184 = @adaptor.create_with_payload( char_literal184 )
      @adaptor.add_child( root_0, tree_for_char_literal184 )


      # at line 438:7: ( NL )*
      while true # decision 74
        alt_74 = 2
        look_74_0 = @input.peek( 1 )

        if ( look_74_0 == NL )
          alt_74 = 1

        end
        case alt_74
        when 1
          # at line 438:7: NL
          __NL185__ = match( NL, TOKENS_FOLLOWING_NL_IN_sometime_constraint_1189 )
          tree_for_NL185 = @adaptor.create_with_payload( __NL185__ )
          @adaptor.add_child( root_0, tree_for_NL185 )



        else
          break # out of loop for decision 74
        end
      end # loop for decision 74

      @state.following.push( TOKENS_FOLLOWING_constraint_body_IN_sometime_constraint_1192 )
      constraint_body186 = constraint_body
      @state.following.pop
      @adaptor.add_child( root_0, constraint_body186.tree )

      char_literal187 = match( T__86, TOKENS_FOLLOWING_T__86_IN_sometime_constraint_1194 )
      tree_for_char_literal187 = @adaptor.create_with_payload( char_literal187 )
      @adaptor.add_child( root_0, tree_for_char_literal187 )



      # --> action
      	self.goto_parent()	
      # <-- action


      # - - - - - - - rule clean up - - - - - - - -
      return_value.stop = @input.look( -1 )


      return_value.tree = @adaptor.rule_post_processing( root_0 )
      @adaptor.set_token_boundaries( return_value.tree, return_value.start, return_value.stop )


      rescue ANTLR3::Error::RecognitionError => re
        report_error(re)
        recover(re)
        return_value.tree = @adaptor.create_error_node( @input, return_value.start, @input.look(-1), re )


      ensure
        # -> uncomment the next line to manually enable rule tracing
        # trace_out( __method__, 30 )


      end

      return return_value
    end

    GoalBodyReturnValue = define_return_scope

    #
    # parser rule goal_body
    #
    # (in SfpLang.g)
    # 443:1: goal_body : ( ( ( constraint_statement | constraint_namespace | constraint_iterator | constraint_class_quantification ) ( NL )+ ) | ( 'always' | 'global' ) ( NL )* '{' ( NL )* constraint_body '}' ( NL )+ | 'sometime' ( NL )* '{' ( NL )* constraint_body '}' ( NL )+ | 'within' NUMBER ( NL )* '{' ( NL )* constraint_body '}' ( NL )+ | 'after' ( NL )* '{' ( NL )* constraint_body '}' ( NL )* ( 'then' | 'within' NUMBER ) ( NL )* '{' ( NL )* constraint_body '}' ( NL )+ | 'before' ( NL )* '{' ( NL )* constraint_body '}' ( NL )* 'then' ( NL )* '{' ( NL )* constraint_body '}' ( NL )+ );
    #
    def goal_body
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 31 )


      return_value = GoalBodyReturnValue.new

      # $rule.start = the first token seen before matching
      return_value.start = @input.look


      root_0 = nil

      __NL192__ = nil
      set193 = nil
      __NL194__ = nil
      char_literal195 = nil
      __NL196__ = nil
      char_literal198 = nil
      __NL199__ = nil
      string_literal200 = nil
      __NL201__ = nil
      char_literal202 = nil
      __NL203__ = nil
      char_literal205 = nil
      __NL206__ = nil
      string_literal207 = nil
      __NUMBER208__ = nil
      __NL209__ = nil
      char_literal210 = nil
      __NL211__ = nil
      char_literal213 = nil
      __NL214__ = nil
      string_literal215 = nil
      __NL216__ = nil
      char_literal217 = nil
      __NL218__ = nil
      char_literal220 = nil
      __NL221__ = nil
      string_literal222 = nil
      string_literal223 = nil
      __NUMBER224__ = nil
      __NL225__ = nil
      char_literal226 = nil
      __NL227__ = nil
      char_literal229 = nil
      __NL230__ = nil
      string_literal231 = nil
      __NL232__ = nil
      char_literal233 = nil
      __NL234__ = nil
      char_literal236 = nil
      __NL237__ = nil
      string_literal238 = nil
      __NL239__ = nil
      char_literal240 = nil
      __NL241__ = nil
      char_literal243 = nil
      __NL244__ = nil
      constraint_statement188 = nil
      constraint_namespace189 = nil
      constraint_iterator190 = nil
      constraint_class_quantification191 = nil
      constraint_body197 = nil
      constraint_body204 = nil
      constraint_body212 = nil
      constraint_body219 = nil
      constraint_body228 = nil
      constraint_body235 = nil
      constraint_body242 = nil


      tree_for_NL192 = nil
      tree_for_set193 = nil
      tree_for_NL194 = nil
      tree_for_char_literal195 = nil
      tree_for_NL196 = nil
      tree_for_char_literal198 = nil
      tree_for_NL199 = nil
      tree_for_string_literal200 = nil
      tree_for_NL201 = nil
      tree_for_char_literal202 = nil
      tree_for_NL203 = nil
      tree_for_char_literal205 = nil
      tree_for_NL206 = nil
      tree_for_string_literal207 = nil
      tree_for_NUMBER208 = nil
      tree_for_NL209 = nil
      tree_for_char_literal210 = nil
      tree_for_NL211 = nil
      tree_for_char_literal213 = nil
      tree_for_NL214 = nil
      tree_for_string_literal215 = nil
      tree_for_NL216 = nil
      tree_for_char_literal217 = nil
      tree_for_NL218 = nil
      tree_for_char_literal220 = nil
      tree_for_NL221 = nil
      tree_for_string_literal222 = nil
      tree_for_string_literal223 = nil
      tree_for_NUMBER224 = nil
      tree_for_NL225 = nil
      tree_for_char_literal226 = nil
      tree_for_NL227 = nil
      tree_for_char_literal229 = nil
      tree_for_NL230 = nil
      tree_for_string_literal231 = nil
      tree_for_NL232 = nil
      tree_for_char_literal233 = nil
      tree_for_NL234 = nil
      tree_for_char_literal236 = nil
      tree_for_NL237 = nil
      tree_for_string_literal238 = nil
      tree_for_NL239 = nil
      tree_for_char_literal240 = nil
      tree_for_NL241 = nil
      tree_for_char_literal243 = nil
      tree_for_NL244 = nil

      begin
      # at line 444:2: ( ( ( constraint_statement | constraint_namespace | constraint_iterator | constraint_class_quantification ) ( NL )+ ) | ( 'always' | 'global' ) ( NL )* '{' ( NL )* constraint_body '}' ( NL )+ | 'sometime' ( NL )* '{' ( NL )* constraint_body '}' ( NL )+ | 'within' NUMBER ( NL )* '{' ( NL )* constraint_body '}' ( NL )+ | 'after' ( NL )* '{' ( NL )* constraint_body '}' ( NL )* ( 'then' | 'within' NUMBER ) ( NL )* '{' ( NL )* constraint_body '}' ( NL )+ | 'before' ( NL )* '{' ( NL )* constraint_body '}' ( NL )* 'then' ( NL )* '{' ( NL )* constraint_body '}' ( NL )+ )
      alt_99 = 6
      case look_99 = @input.peek( 1 )
      when ID, T__54, T__57, T__58, T__59, T__63, T__73, T__83 then alt_99 = 1
      when T__40, T__60 then alt_99 = 2
      when T__78 then alt_99 = 3
      when T__84 then alt_99 = 4
      when T__39 then alt_99 = 5
      when T__44 then alt_99 = 6
      else
        raise NoViableAlternative( "", 99, 0 )

      end
      case alt_99
      when 1
        root_0 = @adaptor.create_flat_list


        # at line 444:4: ( ( constraint_statement | constraint_namespace | constraint_iterator | constraint_class_quantification ) ( NL )+ )
        # at line 444:4: ( ( constraint_statement | constraint_namespace | constraint_iterator | constraint_class_quantification ) ( NL )+ )
        # at line 445:4: ( constraint_statement | constraint_namespace | constraint_iterator | constraint_class_quantification ) ( NL )+
        # at line 445:4: ( constraint_statement | constraint_namespace | constraint_iterator | constraint_class_quantification )
        alt_75 = 4
        alt_75 = @dfa75.predict( @input )
        case alt_75
        when 1
          # at line 445:6: constraint_statement
          @state.following.push( TOKENS_FOLLOWING_constraint_statement_IN_goal_body_1217 )
          constraint_statement188 = constraint_statement
          @state.following.pop
          @adaptor.add_child( root_0, constraint_statement188.tree )


          # --> action

          					@now[( constraint_statement188.nil? ? nil : constraint_statement188.key )] = ( constraint_statement188.nil? ? nil : constraint_statement188.val )
          				
          # <-- action


        when 2
          # at line 449:6: constraint_namespace
          @state.following.push( TOKENS_FOLLOWING_constraint_namespace_IN_goal_body_1230 )
          constraint_namespace189 = constraint_namespace
          @state.following.pop
          @adaptor.add_child( root_0, constraint_namespace189.tree )


        when 3
          # at line 450:6: constraint_iterator
          @state.following.push( TOKENS_FOLLOWING_constraint_iterator_IN_goal_body_1237 )
          constraint_iterator190 = constraint_iterator
          @state.following.pop
          @adaptor.add_child( root_0, constraint_iterator190.tree )


        when 4
          # at line 451:6: constraint_class_quantification
          @state.following.push( TOKENS_FOLLOWING_constraint_class_quantification_IN_goal_body_1244 )
          constraint_class_quantification191 = constraint_class_quantification
          @state.following.pop
          @adaptor.add_child( root_0, constraint_class_quantification191.tree )


        end
        # at file 453:3: ( NL )+
        match_count_76 = 0
        while true
          alt_76 = 2
          look_76_0 = @input.peek( 1 )

          if ( look_76_0 == NL )
            alt_76 = 1

          end
          case alt_76
          when 1
            # at line 453:3: NL
            __NL192__ = match( NL, TOKENS_FOLLOWING_NL_IN_goal_body_1253 )
            tree_for_NL192 = @adaptor.create_with_payload( __NL192__ )
            @adaptor.add_child( root_0, tree_for_NL192 )



          else
            match_count_76 > 0 and break
            eee = EarlyExit(76)


            raise eee
          end
          match_count_76 += 1
        end




      when 2
        root_0 = @adaptor.create_flat_list


        # at line 454:4: ( 'always' | 'global' ) ( NL )* '{' ( NL )* constraint_body '}' ( NL )+
        set193 = @input.look

        if @input.peek(1) == T__40 || @input.peek(1) == T__60
          @input.consume
          @adaptor.add_child( root_0, @adaptor.create_with_payload( set193 ) )

          @state.error_recovery = false

        else
          mse = MismatchedSet( nil )
          raise mse

        end


        # at line 454:24: ( NL )*
        while true # decision 77
          alt_77 = 2
          look_77_0 = @input.peek( 1 )

          if ( look_77_0 == NL )
            alt_77 = 1

          end
          case alt_77
          when 1
            # at line 454:24: NL
            __NL194__ = match( NL, TOKENS_FOLLOWING_NL_IN_goal_body_1266 )
            tree_for_NL194 = @adaptor.create_with_payload( __NL194__ )
            @adaptor.add_child( root_0, tree_for_NL194 )



          else
            break # out of loop for decision 77
          end
        end # loop for decision 77


        # --> action

        			@now['global'] = self.create_constraint('global', 'and') if
        				not @now.has_key?('global')
        			@now = @now['global']
        		
        # <-- action

        char_literal195 = match( T__85, TOKENS_FOLLOWING_T__85_IN_goal_body_1275 )
        tree_for_char_literal195 = @adaptor.create_with_payload( char_literal195 )
        @adaptor.add_child( root_0, tree_for_char_literal195 )


        # at line 460:7: ( NL )*
        while true # decision 78
          alt_78 = 2
          look_78_0 = @input.peek( 1 )

          if ( look_78_0 == NL )
            alt_78 = 1

          end
          case alt_78
          when 1
            # at line 460:7: NL
            __NL196__ = match( NL, TOKENS_FOLLOWING_NL_IN_goal_body_1277 )
            tree_for_NL196 = @adaptor.create_with_payload( __NL196__ )
            @adaptor.add_child( root_0, tree_for_NL196 )



          else
            break # out of loop for decision 78
          end
        end # loop for decision 78

        @state.following.push( TOKENS_FOLLOWING_constraint_body_IN_goal_body_1280 )
        constraint_body197 = constraint_body
        @state.following.pop
        @adaptor.add_child( root_0, constraint_body197.tree )

        char_literal198 = match( T__86, TOKENS_FOLLOWING_T__86_IN_goal_body_1282 )
        tree_for_char_literal198 = @adaptor.create_with_payload( char_literal198 )
        @adaptor.add_child( root_0, tree_for_char_literal198 )


        # at file 460:31: ( NL )+
        match_count_79 = 0
        while true
          alt_79 = 2
          look_79_0 = @input.peek( 1 )

          if ( look_79_0 == NL )
            alt_79 = 1

          end
          case alt_79
          when 1
            # at line 460:31: NL
            __NL199__ = match( NL, TOKENS_FOLLOWING_NL_IN_goal_body_1284 )
            tree_for_NL199 = @adaptor.create_with_payload( __NL199__ )
            @adaptor.add_child( root_0, tree_for_NL199 )



          else
            match_count_79 > 0 and break
            eee = EarlyExit(79)


            raise eee
          end
          match_count_79 += 1
        end



        # --> action
        	self.goto_parent()	
        # <-- action


      when 3
        root_0 = @adaptor.create_flat_list


        # at line 462:4: 'sometime' ( NL )* '{' ( NL )* constraint_body '}' ( NL )+
        string_literal200 = match( T__78, TOKENS_FOLLOWING_T__78_IN_goal_body_1294 )
        tree_for_string_literal200 = @adaptor.create_with_payload( string_literal200 )
        @adaptor.add_child( root_0, tree_for_string_literal200 )


        # at line 462:15: ( NL )*
        while true # decision 80
          alt_80 = 2
          look_80_0 = @input.peek( 1 )

          if ( look_80_0 == NL )
            alt_80 = 1

          end
          case alt_80
          when 1
            # at line 462:15: NL
            __NL201__ = match( NL, TOKENS_FOLLOWING_NL_IN_goal_body_1296 )
            tree_for_NL201 = @adaptor.create_with_payload( __NL201__ )
            @adaptor.add_child( root_0, tree_for_NL201 )



          else
            break # out of loop for decision 80
          end
        end # loop for decision 80


        # --> action

        			@now['sometime'] = self.create_constraint('sometime', 'or') if
        				not @now.has_key?('sometime')
        			@now = @now['sometime']
        			id = self.next_id.to_s
        			@now[id] = self.create_constraint(id, 'and')
        			@now = @now[id]
        		
        # <-- action

        char_literal202 = match( T__85, TOKENS_FOLLOWING_T__85_IN_goal_body_1305 )
        tree_for_char_literal202 = @adaptor.create_with_payload( char_literal202 )
        @adaptor.add_child( root_0, tree_for_char_literal202 )


        # at line 471:7: ( NL )*
        while true # decision 81
          alt_81 = 2
          look_81_0 = @input.peek( 1 )

          if ( look_81_0 == NL )
            alt_81 = 1

          end
          case alt_81
          when 1
            # at line 471:7: NL
            __NL203__ = match( NL, TOKENS_FOLLOWING_NL_IN_goal_body_1307 )
            tree_for_NL203 = @adaptor.create_with_payload( __NL203__ )
            @adaptor.add_child( root_0, tree_for_NL203 )



          else
            break # out of loop for decision 81
          end
        end # loop for decision 81

        @state.following.push( TOKENS_FOLLOWING_constraint_body_IN_goal_body_1310 )
        constraint_body204 = constraint_body
        @state.following.pop
        @adaptor.add_child( root_0, constraint_body204.tree )

        char_literal205 = match( T__86, TOKENS_FOLLOWING_T__86_IN_goal_body_1312 )
        tree_for_char_literal205 = @adaptor.create_with_payload( char_literal205 )
        @adaptor.add_child( root_0, tree_for_char_literal205 )


        # at file 471:31: ( NL )+
        match_count_82 = 0
        while true
          alt_82 = 2
          look_82_0 = @input.peek( 1 )

          if ( look_82_0 == NL )
            alt_82 = 1

          end
          case alt_82
          when 1
            # at line 471:31: NL
            __NL206__ = match( NL, TOKENS_FOLLOWING_NL_IN_goal_body_1314 )
            tree_for_NL206 = @adaptor.create_with_payload( __NL206__ )
            @adaptor.add_child( root_0, tree_for_NL206 )



          else
            match_count_82 > 0 and break
            eee = EarlyExit(82)


            raise eee
          end
          match_count_82 += 1
        end



        # --> action
        	self.goto_parent()	
        # <-- action


        # --> action
        	self.goto_parent()	
        # <-- action


      when 4
        root_0 = @adaptor.create_flat_list


        # at line 474:4: 'within' NUMBER ( NL )* '{' ( NL )* constraint_body '}' ( NL )+
        string_literal207 = match( T__84, TOKENS_FOLLOWING_T__84_IN_goal_body_1328 )
        tree_for_string_literal207 = @adaptor.create_with_payload( string_literal207 )
        @adaptor.add_child( root_0, tree_for_string_literal207 )


        __NUMBER208__ = match( NUMBER, TOKENS_FOLLOWING_NUMBER_IN_goal_body_1330 )
        tree_for_NUMBER208 = @adaptor.create_with_payload( __NUMBER208__ )
        @adaptor.add_child( root_0, tree_for_NUMBER208 )


        # at line 474:20: ( NL )*
        while true # decision 83
          alt_83 = 2
          look_83_0 = @input.peek( 1 )

          if ( look_83_0 == NL )
            alt_83 = 1

          end
          case alt_83
          when 1
            # at line 474:20: NL
            __NL209__ = match( NL, TOKENS_FOLLOWING_NL_IN_goal_body_1332 )
            tree_for_NL209 = @adaptor.create_with_payload( __NL209__ )
            @adaptor.add_child( root_0, tree_for_NL209 )



          else
            break # out of loop for decision 83
          end
        end # loop for decision 83


        # --> action

        			id = self.next_id.to_s
        			@now[id] = self.create_constraint(id, 'within')
        			@now = @now[id]
        			@now['deadline'] = __NUMBER208__.text.to_s.to_i
        		
        # <-- action

        char_literal210 = match( T__85, TOKENS_FOLLOWING_T__85_IN_goal_body_1341 )
        tree_for_char_literal210 = @adaptor.create_with_payload( char_literal210 )
        @adaptor.add_child( root_0, tree_for_char_literal210 )


        # at line 481:7: ( NL )*
        while true # decision 84
          alt_84 = 2
          look_84_0 = @input.peek( 1 )

          if ( look_84_0 == NL )
            alt_84 = 1

          end
          case alt_84
          when 1
            # at line 481:7: NL
            __NL211__ = match( NL, TOKENS_FOLLOWING_NL_IN_goal_body_1343 )
            tree_for_NL211 = @adaptor.create_with_payload( __NL211__ )
            @adaptor.add_child( root_0, tree_for_NL211 )



          else
            break # out of loop for decision 84
          end
        end # loop for decision 84

        @state.following.push( TOKENS_FOLLOWING_constraint_body_IN_goal_body_1346 )
        constraint_body212 = constraint_body
        @state.following.pop
        @adaptor.add_child( root_0, constraint_body212.tree )

        char_literal213 = match( T__86, TOKENS_FOLLOWING_T__86_IN_goal_body_1348 )
        tree_for_char_literal213 = @adaptor.create_with_payload( char_literal213 )
        @adaptor.add_child( root_0, tree_for_char_literal213 )


        # at file 481:31: ( NL )+
        match_count_85 = 0
        while true
          alt_85 = 2
          look_85_0 = @input.peek( 1 )

          if ( look_85_0 == NL )
            alt_85 = 1

          end
          case alt_85
          when 1
            # at line 481:31: NL
            __NL214__ = match( NL, TOKENS_FOLLOWING_NL_IN_goal_body_1350 )
            tree_for_NL214 = @adaptor.create_with_payload( __NL214__ )
            @adaptor.add_child( root_0, tree_for_NL214 )



          else
            match_count_85 > 0 and break
            eee = EarlyExit(85)


            raise eee
          end
          match_count_85 += 1
        end



        # --> action
        	self.goto_parent()	
        # <-- action


      when 5
        root_0 = @adaptor.create_flat_list


        # at line 483:4: 'after' ( NL )* '{' ( NL )* constraint_body '}' ( NL )* ( 'then' | 'within' NUMBER ) ( NL )* '{' ( NL )* constraint_body '}' ( NL )+
        string_literal215 = match( T__39, TOKENS_FOLLOWING_T__39_IN_goal_body_1360 )
        tree_for_string_literal215 = @adaptor.create_with_payload( string_literal215 )
        @adaptor.add_child( root_0, tree_for_string_literal215 )


        # at line 483:12: ( NL )*
        while true # decision 86
          alt_86 = 2
          look_86_0 = @input.peek( 1 )

          if ( look_86_0 == NL )
            alt_86 = 1

          end
          case alt_86
          when 1
            # at line 483:12: NL
            __NL216__ = match( NL, TOKENS_FOLLOWING_NL_IN_goal_body_1362 )
            tree_for_NL216 = @adaptor.create_with_payload( __NL216__ )
            @adaptor.add_child( root_0, tree_for_NL216 )



          else
            break # out of loop for decision 86
          end
        end # loop for decision 86


        # --> action

        			@now['sometime-after'] = self.create_constraint('sometime-after', 'or') if
        				not @now.has_key?('sometime-after')
        			@now = @now['sometime-after']

        			id = self.next_id.to_s
        			@now[id] = self.create_constraint(id, 'sometime-after')
        			@now = @now[id]
        			@now['after'] = self.create_constraint('after')
        			@now['deadline'] = -1
        			@now = @now['after']
        		
        # <-- action

        char_literal217 = match( T__85, TOKENS_FOLLOWING_T__85_IN_goal_body_1371 )
        tree_for_char_literal217 = @adaptor.create_with_payload( char_literal217 )
        @adaptor.add_child( root_0, tree_for_char_literal217 )


        # at line 496:7: ( NL )*
        while true # decision 87
          alt_87 = 2
          look_87_0 = @input.peek( 1 )

          if ( look_87_0 == NL )
            alt_87 = 1

          end
          case alt_87
          when 1
            # at line 496:7: NL
            __NL218__ = match( NL, TOKENS_FOLLOWING_NL_IN_goal_body_1373 )
            tree_for_NL218 = @adaptor.create_with_payload( __NL218__ )
            @adaptor.add_child( root_0, tree_for_NL218 )



          else
            break # out of loop for decision 87
          end
        end # loop for decision 87

        @state.following.push( TOKENS_FOLLOWING_constraint_body_IN_goal_body_1376 )
        constraint_body219 = constraint_body
        @state.following.pop
        @adaptor.add_child( root_0, constraint_body219.tree )

        char_literal220 = match( T__86, TOKENS_FOLLOWING_T__86_IN_goal_body_1378 )
        tree_for_char_literal220 = @adaptor.create_with_payload( char_literal220 )
        @adaptor.add_child( root_0, tree_for_char_literal220 )


        # at line 496:31: ( NL )*
        while true # decision 88
          alt_88 = 2
          look_88_0 = @input.peek( 1 )

          if ( look_88_0 == NL )
            alt_88 = 1

          end
          case alt_88
          when 1
            # at line 496:31: NL
            __NL221__ = match( NL, TOKENS_FOLLOWING_NL_IN_goal_body_1380 )
            tree_for_NL221 = @adaptor.create_with_payload( __NL221__ )
            @adaptor.add_child( root_0, tree_for_NL221 )



          else
            break # out of loop for decision 88
          end
        end # loop for decision 88


        # --> action
        	self.goto_parent()	
        # <-- action

        # at line 498:3: ( 'then' | 'within' NUMBER )
        alt_89 = 2
        look_89_0 = @input.peek( 1 )

        if ( look_89_0 == T__82 )
          alt_89 = 1
        elsif ( look_89_0 == T__84 )
          alt_89 = 2
        else
          raise NoViableAlternative( "", 89, 0 )

        end
        case alt_89
        when 1
          # at line 498:5: 'then'
          string_literal222 = match( T__82, TOKENS_FOLLOWING_T__82_IN_goal_body_1391 )
          tree_for_string_literal222 = @adaptor.create_with_payload( string_literal222 )
          @adaptor.add_child( root_0, tree_for_string_literal222 )



        when 2
          # at line 499:6: 'within' NUMBER
          string_literal223 = match( T__84, TOKENS_FOLLOWING_T__84_IN_goal_body_1398 )
          tree_for_string_literal223 = @adaptor.create_with_payload( string_literal223 )
          @adaptor.add_child( root_0, tree_for_string_literal223 )


          __NUMBER224__ = match( NUMBER, TOKENS_FOLLOWING_NUMBER_IN_goal_body_1400 )
          tree_for_NUMBER224 = @adaptor.create_with_payload( __NUMBER224__ )
          @adaptor.add_child( root_0, tree_for_NUMBER224 )



          # --> action
           @now['deadline'] = __NUMBER224__.text.to_s.to_i 
          # <-- action


        end
        # at line 501:5: ( NL )*
        while true # decision 90
          alt_90 = 2
          look_90_0 = @input.peek( 1 )

          if ( look_90_0 == NL )
            alt_90 = 1

          end
          case alt_90
          when 1
            # at line 501:5: NL
            __NL225__ = match( NL, TOKENS_FOLLOWING_NL_IN_goal_body_1412 )
            tree_for_NL225 = @adaptor.create_with_payload( __NL225__ )
            @adaptor.add_child( root_0, tree_for_NL225 )



          else
            break # out of loop for decision 90
          end
        end # loop for decision 90


        # --> action

        			@now['then'] = self.create_constraint('then')
        			@now = @now['then']
        		
        # <-- action

        char_literal226 = match( T__85, TOKENS_FOLLOWING_T__85_IN_goal_body_1421 )
        tree_for_char_literal226 = @adaptor.create_with_payload( char_literal226 )
        @adaptor.add_child( root_0, tree_for_char_literal226 )


        # at line 506:7: ( NL )*
        while true # decision 91
          alt_91 = 2
          look_91_0 = @input.peek( 1 )

          if ( look_91_0 == NL )
            alt_91 = 1

          end
          case alt_91
          when 1
            # at line 506:7: NL
            __NL227__ = match( NL, TOKENS_FOLLOWING_NL_IN_goal_body_1423 )
            tree_for_NL227 = @adaptor.create_with_payload( __NL227__ )
            @adaptor.add_child( root_0, tree_for_NL227 )



          else
            break # out of loop for decision 91
          end
        end # loop for decision 91

        @state.following.push( TOKENS_FOLLOWING_constraint_body_IN_goal_body_1426 )
        constraint_body228 = constraint_body
        @state.following.pop
        @adaptor.add_child( root_0, constraint_body228.tree )

        char_literal229 = match( T__86, TOKENS_FOLLOWING_T__86_IN_goal_body_1428 )
        tree_for_char_literal229 = @adaptor.create_with_payload( char_literal229 )
        @adaptor.add_child( root_0, tree_for_char_literal229 )


        # at file 506:31: ( NL )+
        match_count_92 = 0
        while true
          alt_92 = 2
          look_92_0 = @input.peek( 1 )

          if ( look_92_0 == NL )
            alt_92 = 1

          end
          case alt_92
          when 1
            # at line 506:31: NL
            __NL230__ = match( NL, TOKENS_FOLLOWING_NL_IN_goal_body_1430 )
            tree_for_NL230 = @adaptor.create_with_payload( __NL230__ )
            @adaptor.add_child( root_0, tree_for_NL230 )



          else
            match_count_92 > 0 and break
            eee = EarlyExit(92)


            raise eee
          end
          match_count_92 += 1
        end



        # --> action
        	self.goto_parent()	
        # <-- action


        # --> action
        	self.goto_parent()	
        # <-- action


        # --> action
        	self.goto_parent()	
        # <-- action


      when 6
        root_0 = @adaptor.create_flat_list


        # at line 510:4: 'before' ( NL )* '{' ( NL )* constraint_body '}' ( NL )* 'then' ( NL )* '{' ( NL )* constraint_body '}' ( NL )+
        string_literal231 = match( T__44, TOKENS_FOLLOWING_T__44_IN_goal_body_1448 )
        tree_for_string_literal231 = @adaptor.create_with_payload( string_literal231 )
        @adaptor.add_child( root_0, tree_for_string_literal231 )


        # at line 510:13: ( NL )*
        while true # decision 93
          alt_93 = 2
          look_93_0 = @input.peek( 1 )

          if ( look_93_0 == NL )
            alt_93 = 1

          end
          case alt_93
          when 1
            # at line 510:13: NL
            __NL232__ = match( NL, TOKENS_FOLLOWING_NL_IN_goal_body_1450 )
            tree_for_NL232 = @adaptor.create_with_payload( __NL232__ )
            @adaptor.add_child( root_0, tree_for_NL232 )



          else
            break # out of loop for decision 93
          end
        end # loop for decision 93


        # --> action

        			id = self.next_id.to_s
        			@now[id] = self.create_constraint(id, 'sometime-before')
        			@now = @now[id]
        			@now['before'] = self.create_constraint('before')
        			@now = @now['before']
        		
        # <-- action

        char_literal233 = match( T__85, TOKENS_FOLLOWING_T__85_IN_goal_body_1459 )
        tree_for_char_literal233 = @adaptor.create_with_payload( char_literal233 )
        @adaptor.add_child( root_0, tree_for_char_literal233 )


        # at line 518:7: ( NL )*
        while true # decision 94
          alt_94 = 2
          look_94_0 = @input.peek( 1 )

          if ( look_94_0 == NL )
            alt_94 = 1

          end
          case alt_94
          when 1
            # at line 518:7: NL
            __NL234__ = match( NL, TOKENS_FOLLOWING_NL_IN_goal_body_1461 )
            tree_for_NL234 = @adaptor.create_with_payload( __NL234__ )
            @adaptor.add_child( root_0, tree_for_NL234 )



          else
            break # out of loop for decision 94
          end
        end # loop for decision 94

        @state.following.push( TOKENS_FOLLOWING_constraint_body_IN_goal_body_1464 )
        constraint_body235 = constraint_body
        @state.following.pop
        @adaptor.add_child( root_0, constraint_body235.tree )

        char_literal236 = match( T__86, TOKENS_FOLLOWING_T__86_IN_goal_body_1466 )
        tree_for_char_literal236 = @adaptor.create_with_payload( char_literal236 )
        @adaptor.add_child( root_0, tree_for_char_literal236 )


        # at line 518:31: ( NL )*
        while true # decision 95
          alt_95 = 2
          look_95_0 = @input.peek( 1 )

          if ( look_95_0 == NL )
            alt_95 = 1

          end
          case alt_95
          when 1
            # at line 518:31: NL
            __NL237__ = match( NL, TOKENS_FOLLOWING_NL_IN_goal_body_1468 )
            tree_for_NL237 = @adaptor.create_with_payload( __NL237__ )
            @adaptor.add_child( root_0, tree_for_NL237 )



          else
            break # out of loop for decision 95
          end
        end # loop for decision 95


        # --> action
        	self.goto_parent()	
        # <-- action

        string_literal238 = match( T__82, TOKENS_FOLLOWING_T__82_IN_goal_body_1477 )
        tree_for_string_literal238 = @adaptor.create_with_payload( string_literal238 )
        @adaptor.add_child( root_0, tree_for_string_literal238 )


        # at line 520:10: ( NL )*
        while true # decision 96
          alt_96 = 2
          look_96_0 = @input.peek( 1 )

          if ( look_96_0 == NL )
            alt_96 = 1

          end
          case alt_96
          when 1
            # at line 520:10: NL
            __NL239__ = match( NL, TOKENS_FOLLOWING_NL_IN_goal_body_1479 )
            tree_for_NL239 = @adaptor.create_with_payload( __NL239__ )
            @adaptor.add_child( root_0, tree_for_NL239 )



          else
            break # out of loop for decision 96
          end
        end # loop for decision 96


        # --> action

        			@now['then'] = self.create_constraint('then')
        			@now = @now['then']
        		
        # <-- action

        char_literal240 = match( T__85, TOKENS_FOLLOWING_T__85_IN_goal_body_1488 )
        tree_for_char_literal240 = @adaptor.create_with_payload( char_literal240 )
        @adaptor.add_child( root_0, tree_for_char_literal240 )


        # at line 525:7: ( NL )*
        while true # decision 97
          alt_97 = 2
          look_97_0 = @input.peek( 1 )

          if ( look_97_0 == NL )
            alt_97 = 1

          end
          case alt_97
          when 1
            # at line 525:7: NL
            __NL241__ = match( NL, TOKENS_FOLLOWING_NL_IN_goal_body_1490 )
            tree_for_NL241 = @adaptor.create_with_payload( __NL241__ )
            @adaptor.add_child( root_0, tree_for_NL241 )



          else
            break # out of loop for decision 97
          end
        end # loop for decision 97

        @state.following.push( TOKENS_FOLLOWING_constraint_body_IN_goal_body_1493 )
        constraint_body242 = constraint_body
        @state.following.pop
        @adaptor.add_child( root_0, constraint_body242.tree )

        char_literal243 = match( T__86, TOKENS_FOLLOWING_T__86_IN_goal_body_1495 )
        tree_for_char_literal243 = @adaptor.create_with_payload( char_literal243 )
        @adaptor.add_child( root_0, tree_for_char_literal243 )


        # at file 525:31: ( NL )+
        match_count_98 = 0
        while true
          alt_98 = 2
          look_98_0 = @input.peek( 1 )

          if ( look_98_0 == NL )
            alt_98 = 1

          end
          case alt_98
          when 1
            # at line 525:31: NL
            __NL244__ = match( NL, TOKENS_FOLLOWING_NL_IN_goal_body_1497 )
            tree_for_NL244 = @adaptor.create_with_payload( __NL244__ )
            @adaptor.add_child( root_0, tree_for_NL244 )



          else
            match_count_98 > 0 and break
            eee = EarlyExit(98)


            raise eee
          end
          match_count_98 += 1
        end



        # --> action
        	self.goto_parent()	
        # <-- action


        # --> action
        	self.goto_parent()	
        # <-- action


      end
      # - - - - - - - rule clean up - - - - - - - -
      return_value.stop = @input.look( -1 )


      return_value.tree = @adaptor.rule_post_processing( root_0 )
      @adaptor.set_token_boundaries( return_value.tree, return_value.start, return_value.stop )


      rescue ANTLR3::Error::RecognitionError => re
        report_error(re)
        recover(re)
        return_value.tree = @adaptor.create_error_node( @input, return_value.start, @input.look(-1), re )


      ensure
        # -> uncomment the next line to manually enable rule tracing
        # trace_out( __method__, 31 )


      end

      return return_value
    end

    NestedConstraintReturnValue = define_return_scope

    #
    # parser rule nested_constraint
    #
    # (in SfpLang.g)
    # 530:1: nested_constraint : '{' ( NL )* constraint_body '}' ;
    #
    def nested_constraint
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 32 )


      return_value = NestedConstraintReturnValue.new

      # $rule.start = the first token seen before matching
      return_value.start = @input.look


      root_0 = nil

      char_literal245 = nil
      __NL246__ = nil
      char_literal248 = nil
      constraint_body247 = nil


      tree_for_char_literal245 = nil
      tree_for_NL246 = nil
      tree_for_char_literal248 = nil

      begin
      root_0 = @adaptor.create_flat_list


      # at line 531:4: '{' ( NL )* constraint_body '}'
      char_literal245 = match( T__85, TOKENS_FOLLOWING_T__85_IN_nested_constraint_1517 )
      tree_for_char_literal245 = @adaptor.create_with_payload( char_literal245 )
      @adaptor.add_child( root_0, tree_for_char_literal245 )


      # at line 531:8: ( NL )*
      while true # decision 100
        alt_100 = 2
        look_100_0 = @input.peek( 1 )

        if ( look_100_0 == NL )
          alt_100 = 1

        end
        case alt_100
        when 1
          # at line 531:8: NL
          __NL246__ = match( NL, TOKENS_FOLLOWING_NL_IN_nested_constraint_1519 )
          tree_for_NL246 = @adaptor.create_with_payload( __NL246__ )
          @adaptor.add_child( root_0, tree_for_NL246 )



        else
          break # out of loop for decision 100
        end
      end # loop for decision 100

      @state.following.push( TOKENS_FOLLOWING_constraint_body_IN_nested_constraint_1522 )
      constraint_body247 = constraint_body
      @state.following.pop
      @adaptor.add_child( root_0, constraint_body247.tree )

      char_literal248 = match( T__86, TOKENS_FOLLOWING_T__86_IN_nested_constraint_1524 )
      tree_for_char_literal248 = @adaptor.create_with_payload( char_literal248 )
      @adaptor.add_child( root_0, tree_for_char_literal248 )



      # - - - - - - - rule clean up - - - - - - - -
      return_value.stop = @input.look( -1 )


      return_value.tree = @adaptor.rule_post_processing( root_0 )
      @adaptor.set_token_boundaries( return_value.tree, return_value.start, return_value.stop )


      rescue ANTLR3::Error::RecognitionError => re
        report_error(re)
        recover(re)
        return_value.tree = @adaptor.create_error_node( @input, return_value.start, @input.look(-1), re )


      ensure
        # -> uncomment the next line to manually enable rule tracing
        # trace_out( __method__, 32 )


      end

      return return_value
    end

    ConstraintReturnValue = define_return_scope

    #
    # parser rule constraint
    #
    # (in SfpLang.g)
    # 534:1: constraint : 'constraint' ID '{' ( NL )* constraint_body '}' ;
    #
    def constraint
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 33 )


      return_value = ConstraintReturnValue.new

      # $rule.start = the first token seen before matching
      return_value.start = @input.look


      root_0 = nil

      string_literal249 = nil
      __ID250__ = nil
      char_literal251 = nil
      __NL252__ = nil
      char_literal254 = nil
      constraint_body253 = nil


      tree_for_string_literal249 = nil
      tree_for_ID250 = nil
      tree_for_char_literal251 = nil
      tree_for_NL252 = nil
      tree_for_char_literal254 = nil

      begin
      root_0 = @adaptor.create_flat_list


      # at line 535:4: 'constraint' ID '{' ( NL )* constraint_body '}'
      string_literal249 = match( T__48, TOKENS_FOLLOWING_T__48_IN_constraint_1535 )
      tree_for_string_literal249 = @adaptor.create_with_payload( string_literal249 )
      @adaptor.add_child( root_0, tree_for_string_literal249 )


      __ID250__ = match( ID, TOKENS_FOLLOWING_ID_IN_constraint_1537 )
      tree_for_ID250 = @adaptor.create_with_payload( __ID250__ )
      @adaptor.add_child( root_0, tree_for_ID250 )



      # --> action

      			@now[__ID250__.text] = self.create_constraint(__ID250__.text, 'and')
      			@now = @now[__ID250__.text]
      		
      # <-- action

      char_literal251 = match( T__85, TOKENS_FOLLOWING_T__85_IN_constraint_1545 )
      tree_for_char_literal251 = @adaptor.create_with_payload( char_literal251 )
      @adaptor.add_child( root_0, tree_for_char_literal251 )


      # at line 540:7: ( NL )*
      while true # decision 101
        alt_101 = 2
        look_101_0 = @input.peek( 1 )

        if ( look_101_0 == NL )
          alt_101 = 1

        end
        case alt_101
        when 1
          # at line 540:7: NL
          __NL252__ = match( NL, TOKENS_FOLLOWING_NL_IN_constraint_1547 )
          tree_for_NL252 = @adaptor.create_with_payload( __NL252__ )
          @adaptor.add_child( root_0, tree_for_NL252 )



        else
          break # out of loop for decision 101
        end
      end # loop for decision 101

      @state.following.push( TOKENS_FOLLOWING_constraint_body_IN_constraint_1550 )
      constraint_body253 = constraint_body
      @state.following.pop
      @adaptor.add_child( root_0, constraint_body253.tree )

      char_literal254 = match( T__86, TOKENS_FOLLOWING_T__86_IN_constraint_1552 )
      tree_for_char_literal254 = @adaptor.create_with_payload( char_literal254 )
      @adaptor.add_child( root_0, tree_for_char_literal254 )



      # --> action
      	self.goto_parent()	
      # <-- action


      # - - - - - - - rule clean up - - - - - - - -
      return_value.stop = @input.look( -1 )


      return_value.tree = @adaptor.rule_post_processing( root_0 )
      @adaptor.set_token_boundaries( return_value.tree, return_value.start, return_value.stop )


      rescue ANTLR3::Error::RecognitionError => re
        report_error(re)
        recover(re)
        return_value.tree = @adaptor.create_error_node( @input, return_value.start, @input.look(-1), re )


      ensure
        # -> uncomment the next line to manually enable rule tracing
        # trace_out( __method__, 33 )


      end

      return return_value
    end

    ConstraintBodyReturnValue = define_return_scope

    #
    # parser rule constraint_body
    #
    # (in SfpLang.g)
    # 544:1: constraint_body : ( ( constraint_statement | constraint_namespace | constraint_iterator | constraint_class_quantification ) ( NL )+ )* ;
    #
    def constraint_body
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 34 )


      return_value = ConstraintBodyReturnValue.new

      # $rule.start = the first token seen before matching
      return_value.start = @input.look


      root_0 = nil

      __NL259__ = nil
      constraint_statement255 = nil
      constraint_namespace256 = nil
      constraint_iterator257 = nil
      constraint_class_quantification258 = nil


      tree_for_NL259 = nil

      begin
      root_0 = @adaptor.create_flat_list


      # at line 545:4: ( ( constraint_statement | constraint_namespace | constraint_iterator | constraint_class_quantification ) ( NL )+ )*
      # at line 545:4: ( ( constraint_statement | constraint_namespace | constraint_iterator | constraint_class_quantification ) ( NL )+ )*
      while true # decision 104
        alt_104 = 2
        look_104_0 = @input.peek( 1 )

        if ( look_104_0 == ID || look_104_0 == T__54 || look_104_0.between?( T__57, T__59 ) || look_104_0 == T__63 || look_104_0 == T__73 || look_104_0 == T__83 )
          alt_104 = 1

        end
        case alt_104
        when 1
          # at line 546:4: ( constraint_statement | constraint_namespace | constraint_iterator | constraint_class_quantification ) ( NL )+
          # at line 546:4: ( constraint_statement | constraint_namespace | constraint_iterator | constraint_class_quantification )
          alt_102 = 4
          alt_102 = @dfa102.predict( @input )
          case alt_102
          when 1
            # at line 546:6: constraint_statement
            @state.following.push( TOKENS_FOLLOWING_constraint_statement_IN_constraint_body_1574 )
            constraint_statement255 = constraint_statement
            @state.following.pop
            @adaptor.add_child( root_0, constraint_statement255.tree )


            # --> action

            					@now[( constraint_statement255.nil? ? nil : constraint_statement255.key )] = ( constraint_statement255.nil? ? nil : constraint_statement255.val )
            				
            # <-- action


          when 2
            # at line 550:6: constraint_namespace
            @state.following.push( TOKENS_FOLLOWING_constraint_namespace_IN_constraint_body_1587 )
            constraint_namespace256 = constraint_namespace
            @state.following.pop
            @adaptor.add_child( root_0, constraint_namespace256.tree )


          when 3
            # at line 551:6: constraint_iterator
            @state.following.push( TOKENS_FOLLOWING_constraint_iterator_IN_constraint_body_1594 )
            constraint_iterator257 = constraint_iterator
            @state.following.pop
            @adaptor.add_child( root_0, constraint_iterator257.tree )


          when 4
            # at line 552:6: constraint_class_quantification
            @state.following.push( TOKENS_FOLLOWING_constraint_class_quantification_IN_constraint_body_1601 )
            constraint_class_quantification258 = constraint_class_quantification
            @state.following.pop
            @adaptor.add_child( root_0, constraint_class_quantification258.tree )


          end
          # at file 554:3: ( NL )+
          match_count_103 = 0
          while true
            alt_103 = 2
            look_103_0 = @input.peek( 1 )

            if ( look_103_0 == NL )
              alt_103 = 1

            end
            case alt_103
            when 1
              # at line 554:3: NL
              __NL259__ = match( NL, TOKENS_FOLLOWING_NL_IN_constraint_body_1610 )
              tree_for_NL259 = @adaptor.create_with_payload( __NL259__ )
              @adaptor.add_child( root_0, tree_for_NL259 )



            else
              match_count_103 > 0 and break
              eee = EarlyExit(103)


              raise eee
            end
            match_count_103 += 1
          end



        else
          break # out of loop for decision 104
        end
      end # loop for decision 104


      # - - - - - - - rule clean up - - - - - - - -
      return_value.stop = @input.look( -1 )


      return_value.tree = @adaptor.rule_post_processing( root_0 )
      @adaptor.set_token_boundaries( return_value.tree, return_value.start, return_value.stop )


      rescue ANTLR3::Error::RecognitionError => re
        report_error(re)
        recover(re)
        return_value.tree = @adaptor.create_error_node( @input, return_value.start, @input.look(-1), re )


      ensure
        # -> uncomment the next line to manually enable rule tracing
        # trace_out( __method__, 34 )


      end

      return return_value
    end

    ConstraintNamespaceReturnValue = define_return_scope

    #
    # parser rule constraint_namespace
    #
    # (in SfpLang.g)
    # 557:1: constraint_namespace : path ( NL )* '{' ( NL )* ( constraint_statement ( NL )+ )* '}' ;
    #
    def constraint_namespace
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 35 )


      return_value = ConstraintNamespaceReturnValue.new

      # $rule.start = the first token seen before matching
      return_value.start = @input.look


      root_0 = nil

      __NL261__ = nil
      char_literal262 = nil
      __NL263__ = nil
      __NL265__ = nil
      char_literal266 = nil
      path260 = nil
      constraint_statement264 = nil


      tree_for_NL261 = nil
      tree_for_char_literal262 = nil
      tree_for_NL263 = nil
      tree_for_NL265 = nil
      tree_for_char_literal266 = nil

      begin
      root_0 = @adaptor.create_flat_list


      # at line 558:4: path ( NL )* '{' ( NL )* ( constraint_statement ( NL )+ )* '}'
      @state.following.push( TOKENS_FOLLOWING_path_IN_constraint_namespace_1624 )
      path260 = path
      @state.following.pop
      @adaptor.add_child( root_0, path260.tree )

      # at line 558:9: ( NL )*
      while true # decision 105
        alt_105 = 2
        look_105_0 = @input.peek( 1 )

        if ( look_105_0 == NL )
          alt_105 = 1

        end
        case alt_105
        when 1
          # at line 558:9: NL
          __NL261__ = match( NL, TOKENS_FOLLOWING_NL_IN_constraint_namespace_1626 )
          tree_for_NL261 = @adaptor.create_with_payload( __NL261__ )
          @adaptor.add_child( root_0, tree_for_NL261 )



        else
          break # out of loop for decision 105
        end
      end # loop for decision 105

      char_literal262 = match( T__85, TOKENS_FOLLOWING_T__85_IN_constraint_namespace_1629 )
      tree_for_char_literal262 = @adaptor.create_with_payload( char_literal262 )
      @adaptor.add_child( root_0, tree_for_char_literal262 )


      # at line 558:17: ( NL )*
      while true # decision 106
        alt_106 = 2
        look_106_0 = @input.peek( 1 )

        if ( look_106_0 == NL )
          alt_106 = 1

        end
        case alt_106
        when 1
          # at line 558:17: NL
          __NL263__ = match( NL, TOKENS_FOLLOWING_NL_IN_constraint_namespace_1631 )
          tree_for_NL263 = @adaptor.create_with_payload( __NL263__ )
          @adaptor.add_child( root_0, tree_for_NL263 )



        else
          break # out of loop for decision 106
        end
      end # loop for decision 106

      # at line 558:21: ( constraint_statement ( NL )+ )*
      while true # decision 108
        alt_108 = 2
        look_108_0 = @input.peek( 1 )

        if ( look_108_0 == ID || look_108_0 == T__63 || look_108_0 == T__73 || look_108_0 == T__83 )
          alt_108 = 1

        end
        case alt_108
        when 1
          # at line 558:22: constraint_statement ( NL )+
          @state.following.push( TOKENS_FOLLOWING_constraint_statement_IN_constraint_namespace_1635 )
          constraint_statement264 = constraint_statement
          @state.following.pop
          @adaptor.add_child( root_0, constraint_statement264.tree )


          # --> action

          			key = self.to_ref(( path260 && @input.to_s( path260.start, path260.stop ) ) + '.' + ( constraint_statement264.nil? ? nil : constraint_statement264.key )[2,( constraint_statement264.nil? ? nil : constraint_statement264.key ).length])
          			@now[key] = ( constraint_statement264.nil? ? nil : constraint_statement264.val )
          		
          # <-- action

          # at file 563:3: ( NL )+
          match_count_107 = 0
          while true
            alt_107 = 2
            look_107_0 = @input.peek( 1 )

            if ( look_107_0 == NL )
              alt_107 = 1

            end
            case alt_107
            when 1
              # at line 563:3: NL
              __NL265__ = match( NL, TOKENS_FOLLOWING_NL_IN_constraint_namespace_1643 )
              tree_for_NL265 = @adaptor.create_with_payload( __NL265__ )
              @adaptor.add_child( root_0, tree_for_NL265 )



            else
              match_count_107 > 0 and break
              eee = EarlyExit(107)


              raise eee
            end
            match_count_107 += 1
          end



        else
          break # out of loop for decision 108
        end
      end # loop for decision 108

      char_literal266 = match( T__86, TOKENS_FOLLOWING_T__86_IN_constraint_namespace_1648 )
      tree_for_char_literal266 = @adaptor.create_with_payload( char_literal266 )
      @adaptor.add_child( root_0, tree_for_char_literal266 )



      # - - - - - - - rule clean up - - - - - - - -
      return_value.stop = @input.look( -1 )


      return_value.tree = @adaptor.rule_post_processing( root_0 )
      @adaptor.set_token_boundaries( return_value.tree, return_value.start, return_value.stop )


      rescue ANTLR3::Error::RecognitionError => re
        report_error(re)
        recover(re)
        return_value.tree = @adaptor.create_error_node( @input, return_value.start, @input.look(-1), re )


      ensure
        # -> uncomment the next line to manually enable rule tracing
        # trace_out( __method__, 35 )


      end

      return return_value
    end

    ConstraintIteratorReturnValue = define_return_scope

    #
    # parser rule constraint_iterator
    #
    # (in SfpLang.g)
    # 566:1: constraint_iterator : 'foreach' '(' path 'as' ID ')' ( NL )* '{' ( NL )+ ( constraint_statement ( NL )+ )* '}' ;
    #
    def constraint_iterator
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 36 )


      return_value = ConstraintIteratorReturnValue.new

      # $rule.start = the first token seen before matching
      return_value.start = @input.look


      root_0 = nil

      string_literal267 = nil
      char_literal268 = nil
      string_literal270 = nil
      __ID271__ = nil
      char_literal272 = nil
      __NL273__ = nil
      char_literal274 = nil
      __NL275__ = nil
      __NL277__ = nil
      char_literal278 = nil
      path269 = nil
      constraint_statement276 = nil


      tree_for_string_literal267 = nil
      tree_for_char_literal268 = nil
      tree_for_string_literal270 = nil
      tree_for_ID271 = nil
      tree_for_char_literal272 = nil
      tree_for_NL273 = nil
      tree_for_char_literal274 = nil
      tree_for_NL275 = nil
      tree_for_NL277 = nil
      tree_for_char_literal278 = nil

      begin
      root_0 = @adaptor.create_flat_list


      # at line 567:4: 'foreach' '(' path 'as' ID ')' ( NL )* '{' ( NL )+ ( constraint_statement ( NL )+ )* '}'
      string_literal267 = match( T__58, TOKENS_FOLLOWING_T__58_IN_constraint_iterator_1659 )
      tree_for_string_literal267 = @adaptor.create_with_payload( string_literal267 )
      @adaptor.add_child( root_0, tree_for_string_literal267 )


      char_literal268 = match( T__20, TOKENS_FOLLOWING_T__20_IN_constraint_iterator_1661 )
      tree_for_char_literal268 = @adaptor.create_with_payload( char_literal268 )
      @adaptor.add_child( root_0, tree_for_char_literal268 )


      @state.following.push( TOKENS_FOLLOWING_path_IN_constraint_iterator_1663 )
      path269 = path
      @state.following.pop
      @adaptor.add_child( root_0, path269.tree )

      string_literal270 = match( T__43, TOKENS_FOLLOWING_T__43_IN_constraint_iterator_1665 )
      tree_for_string_literal270 = @adaptor.create_with_payload( string_literal270 )
      @adaptor.add_child( root_0, tree_for_string_literal270 )


      __ID271__ = match( ID, TOKENS_FOLLOWING_ID_IN_constraint_iterator_1667 )
      tree_for_ID271 = @adaptor.create_with_payload( __ID271__ )
      @adaptor.add_child( root_0, tree_for_ID271 )


      char_literal272 = match( T__21, TOKENS_FOLLOWING_T__21_IN_constraint_iterator_1669 )
      tree_for_char_literal272 = @adaptor.create_with_payload( char_literal272 )
      @adaptor.add_child( root_0, tree_for_char_literal272 )


      # at line 567:35: ( NL )*
      while true # decision 109
        alt_109 = 2
        look_109_0 = @input.peek( 1 )

        if ( look_109_0 == NL )
          alt_109 = 1

        end
        case alt_109
        when 1
          # at line 567:35: NL
          __NL273__ = match( NL, TOKENS_FOLLOWING_NL_IN_constraint_iterator_1671 )
          tree_for_NL273 = @adaptor.create_with_payload( __NL273__ )
          @adaptor.add_child( root_0, tree_for_NL273 )



        else
          break # out of loop for decision 109
        end
      end # loop for decision 109

      char_literal274 = match( T__85, TOKENS_FOLLOWING_T__85_IN_constraint_iterator_1674 )
      tree_for_char_literal274 = @adaptor.create_with_payload( char_literal274 )
      @adaptor.add_child( root_0, tree_for_char_literal274 )


      # at file 567:43: ( NL )+
      match_count_110 = 0
      while true
        alt_110 = 2
        look_110_0 = @input.peek( 1 )

        if ( look_110_0 == NL )
          alt_110 = 1

        end
        case alt_110
        when 1
          # at line 567:43: NL
          __NL275__ = match( NL, TOKENS_FOLLOWING_NL_IN_constraint_iterator_1676 )
          tree_for_NL275 = @adaptor.create_with_payload( __NL275__ )
          @adaptor.add_child( root_0, tree_for_NL275 )



        else
          match_count_110 > 0 and break
          eee = EarlyExit(110)


          raise eee
        end
        match_count_110 += 1
      end



      # --> action

      			id = self.next_id.to_s
      			@now[id] = self.create_constraint(id, 'iterator')
      			@now[id]['_value'] = '$.' + ( path269 && @input.to_s( path269.start, path269.stop ) )
      			@now[id]['_variable'] = __ID271__.text
      			@now = @now[id]
      			
      			id = '_template'
      			@now[id] = self.create_constraint(id, 'and')
      			@now = @now[id]
      		
      # <-- action

      # at line 579:3: ( constraint_statement ( NL )+ )*
      while true # decision 112
        alt_112 = 2
        look_112_0 = @input.peek( 1 )

        if ( look_112_0 == ID || look_112_0 == T__63 || look_112_0 == T__73 || look_112_0 == T__83 )
          alt_112 = 1

        end
        case alt_112
        when 1
          # at line 579:4: constraint_statement ( NL )+
          @state.following.push( TOKENS_FOLLOWING_constraint_statement_IN_constraint_iterator_1686 )
          constraint_statement276 = constraint_statement
          @state.following.pop
          @adaptor.add_child( root_0, constraint_statement276.tree )


          # --> action

          			@now[( constraint_statement276.nil? ? nil : constraint_statement276.key )] = ( constraint_statement276.nil? ? nil : constraint_statement276.val )
          		
          # <-- action

          # at file 583:3: ( NL )+
          match_count_111 = 0
          while true
            alt_111 = 2
            look_111_0 = @input.peek( 1 )

            if ( look_111_0 == NL )
              alt_111 = 1

            end
            case alt_111
            when 1
              # at line 583:3: NL
              __NL277__ = match( NL, TOKENS_FOLLOWING_NL_IN_constraint_iterator_1694 )
              tree_for_NL277 = @adaptor.create_with_payload( __NL277__ )
              @adaptor.add_child( root_0, tree_for_NL277 )



            else
              match_count_111 > 0 and break
              eee = EarlyExit(111)


              raise eee
            end
            match_count_111 += 1
          end



        else
          break # out of loop for decision 112
        end
      end # loop for decision 112

      char_literal278 = match( T__86, TOKENS_FOLLOWING_T__86_IN_constraint_iterator_1701 )
      tree_for_char_literal278 = @adaptor.create_with_payload( char_literal278 )
      @adaptor.add_child( root_0, tree_for_char_literal278 )



      # --> action

      			self.goto_parent()
      			self.goto_parent()
      		
      # <-- action


      # - - - - - - - rule clean up - - - - - - - -
      return_value.stop = @input.look( -1 )


      return_value.tree = @adaptor.rule_post_processing( root_0 )
      @adaptor.set_token_boundaries( return_value.tree, return_value.start, return_value.stop )


      rescue ANTLR3::Error::RecognitionError => re
        report_error(re)
        recover(re)
        return_value.tree = @adaptor.create_error_node( @input, return_value.start, @input.look(-1), re )


      ensure
        # -> uncomment the next line to manually enable rule tracing
        # trace_out( __method__, 36 )


      end

      return return_value
    end

    QuantificationKeywordReturnValue = define_return_scope

    #
    # parser rule quantification_keyword
    #
    # (in SfpLang.g)
    # 591:1: quantification_keyword : ( 'forall' | 'exist' | 'forsome' );
    #
    def quantification_keyword
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 37 )


      return_value = QuantificationKeywordReturnValue.new

      # $rule.start = the first token seen before matching
      return_value.start = @input.look


      root_0 = nil

      set279 = nil


      tree_for_set279 = nil

      begin
      root_0 = @adaptor.create_flat_list


      # at line 
      set279 = @input.look

      if @input.peek(1) == T__54 || @input.peek(1) == T__57 || @input.peek(1) == T__59
        @input.consume
        @adaptor.add_child( root_0, @adaptor.create_with_payload( set279 ) )

        @state.error_recovery = false

      else
        mse = MismatchedSet( nil )
        raise mse

      end



      # - - - - - - - rule clean up - - - - - - - -
      return_value.stop = @input.look( -1 )


      return_value.tree = @adaptor.rule_post_processing( root_0 )
      @adaptor.set_token_boundaries( return_value.tree, return_value.start, return_value.stop )


      rescue ANTLR3::Error::RecognitionError => re
        report_error(re)
        recover(re)
        return_value.tree = @adaptor.create_error_node( @input, return_value.start, @input.look(-1), re )


      ensure
        # -> uncomment the next line to manually enable rule tracing
        # trace_out( __method__, 37 )


      end

      return return_value
    end

    ConstraintClassQuantificationReturnValue = define_return_scope

    #
    # parser rule constraint_class_quantification
    #
    # (in SfpLang.g)
    # 597:1: constraint_class_quantification : quantification_keyword '(' path 'as' ID ')' ( ( binary_comp | '=' ) NUMBER )? ( NL )* '{' ( NL )+ ( constraint_statement ( NL )+ | constraint_different ( NL )+ | constraint_iterator ( NL )+ )* '}' ;
    #
    def constraint_class_quantification
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 38 )


      return_value = ConstraintClassQuantificationReturnValue.new

      # $rule.start = the first token seen before matching
      return_value.start = @input.look


      root_0 = nil

      char_literal281 = nil
      string_literal283 = nil
      __ID284__ = nil
      char_literal285 = nil
      char_literal287 = nil
      __NUMBER288__ = nil
      __NL289__ = nil
      char_literal290 = nil
      __NL291__ = nil
      __NL293__ = nil
      __NL295__ = nil
      __NL297__ = nil
      char_literal298 = nil
      quantification_keyword280 = nil
      path282 = nil
      binary_comp286 = nil
      constraint_statement292 = nil
      constraint_different294 = nil
      constraint_iterator296 = nil


      tree_for_char_literal281 = nil
      tree_for_string_literal283 = nil
      tree_for_ID284 = nil
      tree_for_char_literal285 = nil
      tree_for_char_literal287 = nil
      tree_for_NUMBER288 = nil
      tree_for_NL289 = nil
      tree_for_char_literal290 = nil
      tree_for_NL291 = nil
      tree_for_NL293 = nil
      tree_for_NL295 = nil
      tree_for_NL297 = nil
      tree_for_char_literal298 = nil

      begin
      root_0 = @adaptor.create_flat_list


      # at line 598:4: quantification_keyword '(' path 'as' ID ')' ( ( binary_comp | '=' ) NUMBER )? ( NL )* '{' ( NL )+ ( constraint_statement ( NL )+ | constraint_different ( NL )+ | constraint_iterator ( NL )+ )* '}'
      @state.following.push( TOKENS_FOLLOWING_quantification_keyword_IN_constraint_class_quantification_1737 )
      quantification_keyword280 = quantification_keyword
      @state.following.pop
      @adaptor.add_child( root_0, quantification_keyword280.tree )

      char_literal281 = match( T__20, TOKENS_FOLLOWING_T__20_IN_constraint_class_quantification_1739 )
      tree_for_char_literal281 = @adaptor.create_with_payload( char_literal281 )
      @adaptor.add_child( root_0, tree_for_char_literal281 )


      @state.following.push( TOKENS_FOLLOWING_path_IN_constraint_class_quantification_1741 )
      path282 = path
      @state.following.pop
      @adaptor.add_child( root_0, path282.tree )

      string_literal283 = match( T__43, TOKENS_FOLLOWING_T__43_IN_constraint_class_quantification_1743 )
      tree_for_string_literal283 = @adaptor.create_with_payload( string_literal283 )
      @adaptor.add_child( root_0, tree_for_string_literal283 )


      __ID284__ = match( ID, TOKENS_FOLLOWING_ID_IN_constraint_class_quantification_1745 )
      tree_for_ID284 = @adaptor.create_with_payload( __ID284__ )
      @adaptor.add_child( root_0, tree_for_ID284 )


      char_literal285 = match( T__21, TOKENS_FOLLOWING_T__21_IN_constraint_class_quantification_1747 )
      tree_for_char_literal285 = @adaptor.create_with_payload( char_literal285 )
      @adaptor.add_child( root_0, tree_for_char_literal285 )



      # --> action

      			id = self.next_id.to_s
      			@now[id] = { '_parent' => @now,
      				'_context' => 'constraint',
      				'_type' => ( quantification_keyword280 && @input.to_s( quantification_keyword280.start, quantification_keyword280.stop ) ),
      				'_self' => id,
      				'_class' => ( path282 && @input.to_s( path282.start, path282.stop ) ),
      				'_variable' => __ID284__.text
      			}
      			@now = @now[id]

      			id = '_template'
      			@now[id] = self.create_constraint(id, 'and')
      			@now = @now[id]
      		
      # <-- action

      # at line 614:3: ( ( binary_comp | '=' ) NUMBER )?
      alt_114 = 2
      look_114_0 = @input.peek( 1 )

      if ( look_114_0.between?( T__30, T__34 ) )
        alt_114 = 1
      end
      case alt_114
      when 1
        # at line 614:5: ( binary_comp | '=' ) NUMBER
        # at line 614:5: ( binary_comp | '=' )
        alt_113 = 2
        look_113_0 = @input.peek( 1 )

        if ( look_113_0.between?( T__30, T__31 ) || look_113_0.between?( T__33, T__34 ) )
          alt_113 = 1
        elsif ( look_113_0 == T__32 )
          alt_113 = 2
        else
          raise NoViableAlternative( "", 113, 0 )

        end
        case alt_113
        when 1
          # at line 614:7: binary_comp
          @state.following.push( TOKENS_FOLLOWING_binary_comp_IN_constraint_class_quantification_1759 )
          binary_comp286 = binary_comp
          @state.following.pop
          @adaptor.add_child( root_0, binary_comp286.tree )


          # --> action
          	@now['_count_operator'] = ( binary_comp286 && @input.to_s( binary_comp286.start, binary_comp286.stop ) )	
          # <-- action


        when 2
          # at line 616:6: '='
          char_literal287 = match( T__32, TOKENS_FOLLOWING_T__32_IN_constraint_class_quantification_1772 )
          tree_for_char_literal287 = @adaptor.create_with_payload( char_literal287 )
          @adaptor.add_child( root_0, tree_for_char_literal287 )



          # --> action
          	@now['_count_operator'] = '='	
          # <-- action


        end
        __NUMBER288__ = match( NUMBER, TOKENS_FOLLOWING_NUMBER_IN_constraint_class_quantification_1788 )
        tree_for_NUMBER288 = @adaptor.create_with_payload( __NUMBER288__ )
        @adaptor.add_child( root_0, tree_for_NUMBER288 )



        # --> action
        	@now['_count_value'] = __NUMBER288__.text.to_i	
        # <-- action


      end
      # at line 622:3: ( NL )*
      while true # decision 115
        alt_115 = 2
        look_115_0 = @input.peek( 1 )

        if ( look_115_0 == NL )
          alt_115 = 1

        end
        case alt_115
        when 1
          # at line 622:3: NL
          __NL289__ = match( NL, TOKENS_FOLLOWING_NL_IN_constraint_class_quantification_1802 )
          tree_for_NL289 = @adaptor.create_with_payload( __NL289__ )
          @adaptor.add_child( root_0, tree_for_NL289 )



        else
          break # out of loop for decision 115
        end
      end # loop for decision 115

      char_literal290 = match( T__85, TOKENS_FOLLOWING_T__85_IN_constraint_class_quantification_1805 )
      tree_for_char_literal290 = @adaptor.create_with_payload( char_literal290 )
      @adaptor.add_child( root_0, tree_for_char_literal290 )


      # at file 622:11: ( NL )+
      match_count_116 = 0
      while true
        alt_116 = 2
        look_116_0 = @input.peek( 1 )

        if ( look_116_0 == NL )
          alt_116 = 1

        end
        case alt_116
        when 1
          # at line 622:11: NL
          __NL291__ = match( NL, TOKENS_FOLLOWING_NL_IN_constraint_class_quantification_1807 )
          tree_for_NL291 = @adaptor.create_with_payload( __NL291__ )
          @adaptor.add_child( root_0, tree_for_NL291 )



        else
          match_count_116 > 0 and break
          eee = EarlyExit(116)


          raise eee
        end
        match_count_116 += 1
      end


      # at line 623:3: ( constraint_statement ( NL )+ | constraint_different ( NL )+ | constraint_iterator ( NL )+ )*
      while true # decision 120
        alt_120 = 4
        case look_120 = @input.peek( 1 )
        when ID, T__63, T__73, T__83 then alt_120 = 1
        when T__29 then alt_120 = 2
        when T__58 then alt_120 = 3
        end
        case alt_120
        when 1
          # at line 623:5: constraint_statement ( NL )+
          @state.following.push( TOKENS_FOLLOWING_constraint_statement_IN_constraint_class_quantification_1814 )
          constraint_statement292 = constraint_statement
          @state.following.pop
          @adaptor.add_child( root_0, constraint_statement292.tree )


          # --> action
          	@now[( constraint_statement292.nil? ? nil : constraint_statement292.key )] = ( constraint_statement292.nil? ? nil : constraint_statement292.val )	
          # <-- action

          # at file 625:4: ( NL )+
          match_count_117 = 0
          while true
            alt_117 = 2
            look_117_0 = @input.peek( 1 )

            if ( look_117_0 == NL )
              alt_117 = 1

            end
            case alt_117
            when 1
              # at line 625:4: NL
              __NL293__ = match( NL, TOKENS_FOLLOWING_NL_IN_constraint_class_quantification_1824 )
              tree_for_NL293 = @adaptor.create_with_payload( __NL293__ )
              @adaptor.add_child( root_0, tree_for_NL293 )



            else
              match_count_117 > 0 and break
              eee = EarlyExit(117)


              raise eee
            end
            match_count_117 += 1
          end



        when 2
          # at line 626:5: constraint_different ( NL )+
          @state.following.push( TOKENS_FOLLOWING_constraint_different_IN_constraint_class_quantification_1831 )
          constraint_different294 = constraint_different
          @state.following.pop
          @adaptor.add_child( root_0, constraint_different294.tree )

          # at file 626:26: ( NL )+
          match_count_118 = 0
          while true
            alt_118 = 2
            look_118_0 = @input.peek( 1 )

            if ( look_118_0 == NL )
              alt_118 = 1

            end
            case alt_118
            when 1
              # at line 626:26: NL
              __NL295__ = match( NL, TOKENS_FOLLOWING_NL_IN_constraint_class_quantification_1833 )
              tree_for_NL295 = @adaptor.create_with_payload( __NL295__ )
              @adaptor.add_child( root_0, tree_for_NL295 )



            else
              match_count_118 > 0 and break
              eee = EarlyExit(118)


              raise eee
            end
            match_count_118 += 1
          end



        when 3
          # at line 627:5: constraint_iterator ( NL )+
          @state.following.push( TOKENS_FOLLOWING_constraint_iterator_IN_constraint_class_quantification_1840 )
          constraint_iterator296 = constraint_iterator
          @state.following.pop
          @adaptor.add_child( root_0, constraint_iterator296.tree )

          # at file 627:25: ( NL )+
          match_count_119 = 0
          while true
            alt_119 = 2
            look_119_0 = @input.peek( 1 )

            if ( look_119_0 == NL )
              alt_119 = 1

            end
            case alt_119
            when 1
              # at line 627:25: NL
              __NL297__ = match( NL, TOKENS_FOLLOWING_NL_IN_constraint_class_quantification_1842 )
              tree_for_NL297 = @adaptor.create_with_payload( __NL297__ )
              @adaptor.add_child( root_0, tree_for_NL297 )



            else
              match_count_119 > 0 and break
              eee = EarlyExit(119)


              raise eee
            end
            match_count_119 += 1
          end



        else
          break # out of loop for decision 120
        end
      end # loop for decision 120

      char_literal298 = match( T__86, TOKENS_FOLLOWING_T__86_IN_constraint_class_quantification_1850 )
      tree_for_char_literal298 = @adaptor.create_with_payload( char_literal298 )
      @adaptor.add_child( root_0, tree_for_char_literal298 )



      # --> action
      	self.goto_parent()	
      # <-- action


      # --> action
      	self.goto_parent()	
      # <-- action


      # - - - - - - - rule clean up - - - - - - - -
      return_value.stop = @input.look( -1 )


      return_value.tree = @adaptor.rule_post_processing( root_0 )
      @adaptor.set_token_boundaries( return_value.tree, return_value.start, return_value.stop )


      rescue ANTLR3::Error::RecognitionError => re
        report_error(re)
        recover(re)
        return_value.tree = @adaptor.create_error_node( @input, return_value.start, @input.look(-1), re )


      ensure
        # -> uncomment the next line to manually enable rule tracing
        # trace_out( __method__, 38 )


      end

      return return_value
    end

    ConstraintDifferentReturnValue = define_return_scope

    #
    # parser rule constraint_different
    #
    # (in SfpLang.g)
    # 633:1: constraint_different : ':different' '(' path ')' ;
    #
    def constraint_different
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 39 )


      return_value = ConstraintDifferentReturnValue.new

      # $rule.start = the first token seen before matching
      return_value.start = @input.look


      root_0 = nil

      string_literal299 = nil
      char_literal300 = nil
      char_literal302 = nil
      path301 = nil


      tree_for_string_literal299 = nil
      tree_for_char_literal300 = nil
      tree_for_char_literal302 = nil

      begin
      root_0 = @adaptor.create_flat_list


      # at line 634:4: ':different' '(' path ')'
      string_literal299 = match( T__29, TOKENS_FOLLOWING_T__29_IN_constraint_different_1869 )
      tree_for_string_literal299 = @adaptor.create_with_payload( string_literal299 )
      @adaptor.add_child( root_0, tree_for_string_literal299 )


      char_literal300 = match( T__20, TOKENS_FOLLOWING_T__20_IN_constraint_different_1871 )
      tree_for_char_literal300 = @adaptor.create_with_payload( char_literal300 )
      @adaptor.add_child( root_0, tree_for_char_literal300 )


      @state.following.push( TOKENS_FOLLOWING_path_IN_constraint_different_1873 )
      path301 = path
      @state.following.pop
      @adaptor.add_child( root_0, path301.tree )

      char_literal302 = match( T__21, TOKENS_FOLLOWING_T__21_IN_constraint_different_1875 )
      tree_for_char_literal302 = @adaptor.create_with_payload( char_literal302 )
      @adaptor.add_child( root_0, tree_for_char_literal302 )



      # --> action

      			id = self.next_id.to_s
      			@now[id] = { '_parent' => @now,
      				'_context' => 'constraint',
      				'_type' => 'different',
      				'_self' => id,
      				'_path' => ( path301 && @input.to_s( path301.start, path301.stop ) )
      			}
      		
      # <-- action


      # - - - - - - - rule clean up - - - - - - - -
      return_value.stop = @input.look( -1 )


      return_value.tree = @adaptor.rule_post_processing( root_0 )
      @adaptor.set_token_boundaries( return_value.tree, return_value.start, return_value.stop )


      rescue ANTLR3::Error::RecognitionError => re
        report_error(re)
        recover(re)
        return_value.tree = @adaptor.create_error_node( @input, return_value.start, @input.look(-1), re )


      ensure
        # -> uncomment the next line to manually enable rule tracing
        # trace_out( __method__, 39 )


      end

      return return_value
    end

    ConstraintStatementReturnValue = define_return_scope :key, :val

    #
    # parser rule constraint_statement
    #
    # (in SfpLang.g)
    # 646:1: constraint_statement returns [key, val] : ( reference | 'not' reference | reference equals_op value | reference equals_op NULL | reference not_equals_op value | reference not_equals_op NULL | conditional_constraint | reference ( 'is' )? 'in' set_value | reference ( 'isnot' | 'isnt' | 'not' ) 'in' set_value | reference 'has' value | reference binary_comp comp_value | total_constraint );
    #
    def constraint_statement
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 40 )


      return_value = ConstraintStatementReturnValue.new

      # $rule.start = the first token seen before matching
      return_value.start = @input.look


      root_0 = nil

      string_literal304 = nil
      __NULL311__ = nil
      __NULL317__ = nil
      string_literal320 = nil
      string_literal321 = nil
      set324 = nil
      string_literal325 = nil
      string_literal328 = nil
      reference303 = nil
      reference305 = nil
      reference306 = nil
      equals_op307 = nil
      value308 = nil
      reference309 = nil
      equals_op310 = nil
      reference312 = nil
      not_equals_op313 = nil
      value314 = nil
      reference315 = nil
      not_equals_op316 = nil
      conditional_constraint318 = nil
      reference319 = nil
      set_value322 = nil
      reference323 = nil
      set_value326 = nil
      reference327 = nil
      value329 = nil
      reference330 = nil
      binary_comp331 = nil
      comp_value332 = nil
      total_constraint333 = nil


      tree_for_string_literal304 = nil
      tree_for_NULL311 = nil
      tree_for_NULL317 = nil
      tree_for_string_literal320 = nil
      tree_for_string_literal321 = nil
      tree_for_set324 = nil
      tree_for_string_literal325 = nil
      tree_for_string_literal328 = nil

      begin
      # at line 647:2: ( reference | 'not' reference | reference equals_op value | reference equals_op NULL | reference not_equals_op value | reference not_equals_op NULL | conditional_constraint | reference ( 'is' )? 'in' set_value | reference ( 'isnot' | 'isnt' | 'not' ) 'in' set_value | reference 'has' value | reference binary_comp comp_value | total_constraint )
      alt_122 = 12
      alt_122 = @dfa122.predict( @input )
      case alt_122
      when 1
        root_0 = @adaptor.create_flat_list


        # at line 647:4: reference
        @state.following.push( TOKENS_FOLLOWING_reference_IN_constraint_statement_1894 )
        reference303 = reference
        @state.following.pop
        @adaptor.add_child( root_0, reference303.tree )


        # --> action

        			return_value.key = ( reference303.nil? ? nil : reference303.val )
        			return_value.val = { '_context' => 'constraint', '_type' => 'equals', '_value' => true }
        		
        # <-- action


      when 2
        root_0 = @adaptor.create_flat_list


        # at line 652:4: 'not' reference
        string_literal304 = match( T__73, TOKENS_FOLLOWING_T__73_IN_constraint_statement_1903 )
        tree_for_string_literal304 = @adaptor.create_with_payload( string_literal304 )
        @adaptor.add_child( root_0, tree_for_string_literal304 )


        @state.following.push( TOKENS_FOLLOWING_reference_IN_constraint_statement_1905 )
        reference305 = reference
        @state.following.pop
        @adaptor.add_child( root_0, reference305.tree )


        # --> action

        			return_value.key = ( reference305.nil? ? nil : reference305.val )
        			return_value.val = { '_context' => 'constraint', '_type' => 'equals', '_value' => false }
        		
        # <-- action


      when 3
        root_0 = @adaptor.create_flat_list


        # at line 657:4: reference equals_op value
        @state.following.push( TOKENS_FOLLOWING_reference_IN_constraint_statement_1914 )
        reference306 = reference
        @state.following.pop
        @adaptor.add_child( root_0, reference306.tree )

        @state.following.push( TOKENS_FOLLOWING_equals_op_IN_constraint_statement_1916 )
        equals_op307 = equals_op
        @state.following.pop
        @adaptor.add_child( root_0, equals_op307.tree )

        @state.following.push( TOKENS_FOLLOWING_value_IN_constraint_statement_1918 )
        value308 = value
        @state.following.pop
        @adaptor.add_child( root_0, value308.tree )


        # --> action

        			return_value.key = ( reference306.nil? ? nil : reference306.val )
        			return_value.val = { '_context' => 'constraint', '_type' => 'equals', '_value' => ( value308.nil? ? nil : value308.val ) }
        		
        # <-- action


      when 4
        root_0 = @adaptor.create_flat_list


        # at line 662:4: reference equals_op NULL
        @state.following.push( TOKENS_FOLLOWING_reference_IN_constraint_statement_1927 )
        reference309 = reference
        @state.following.pop
        @adaptor.add_child( root_0, reference309.tree )

        @state.following.push( TOKENS_FOLLOWING_equals_op_IN_constraint_statement_1929 )
        equals_op310 = equals_op
        @state.following.pop
        @adaptor.add_child( root_0, equals_op310.tree )

        __NULL311__ = match( NULL, TOKENS_FOLLOWING_NULL_IN_constraint_statement_1931 )
        tree_for_NULL311 = @adaptor.create_with_payload( __NULL311__ )
        @adaptor.add_child( root_0, tree_for_NULL311 )



        # --> action

        			return_value.key = ( reference309.nil? ? nil : reference309.val )
        			return_value.val = { '_context' => 'constraint', '_type' => 'equals', '_value' => self.null_value }
        		
        # <-- action


      when 5
        root_0 = @adaptor.create_flat_list


        # at line 667:4: reference not_equals_op value
        @state.following.push( TOKENS_FOLLOWING_reference_IN_constraint_statement_1940 )
        reference312 = reference
        @state.following.pop
        @adaptor.add_child( root_0, reference312.tree )

        @state.following.push( TOKENS_FOLLOWING_not_equals_op_IN_constraint_statement_1942 )
        not_equals_op313 = not_equals_op
        @state.following.pop
        @adaptor.add_child( root_0, not_equals_op313.tree )

        @state.following.push( TOKENS_FOLLOWING_value_IN_constraint_statement_1944 )
        value314 = value
        @state.following.pop
        @adaptor.add_child( root_0, value314.tree )


        # --> action

        			return_value.key = ( reference312.nil? ? nil : reference312.val )
        			return_value.val = { '_context' => 'constraint', '_type' => 'not-equals', '_value' => ( value314.nil? ? nil : value314.val ) }
        		
        # <-- action


      when 6
        root_0 = @adaptor.create_flat_list


        # at line 672:4: reference not_equals_op NULL
        @state.following.push( TOKENS_FOLLOWING_reference_IN_constraint_statement_1953 )
        reference315 = reference
        @state.following.pop
        @adaptor.add_child( root_0, reference315.tree )

        @state.following.push( TOKENS_FOLLOWING_not_equals_op_IN_constraint_statement_1955 )
        not_equals_op316 = not_equals_op
        @state.following.pop
        @adaptor.add_child( root_0, not_equals_op316.tree )

        __NULL317__ = match( NULL, TOKENS_FOLLOWING_NULL_IN_constraint_statement_1957 )
        tree_for_NULL317 = @adaptor.create_with_payload( __NULL317__ )
        @adaptor.add_child( root_0, tree_for_NULL317 )



        # --> action

        			return_value.key = ( reference315.nil? ? nil : reference315.val )
        			return_value.val = { '_context' => 'constraint', '_type' => 'not-equals', '_value' => self.null_value }
        		
        # <-- action


      when 7
        root_0 = @adaptor.create_flat_list


        # at line 677:4: conditional_constraint
        @state.following.push( TOKENS_FOLLOWING_conditional_constraint_IN_constraint_statement_1966 )
        conditional_constraint318 = conditional_constraint
        @state.following.pop
        @adaptor.add_child( root_0, conditional_constraint318.tree )


        # --> action

        			return_value.key = ( conditional_constraint318.nil? ? nil : conditional_constraint318.key )
        			return_value.val = ( conditional_constraint318.nil? ? nil : conditional_constraint318.val )
        		
        # <-- action


      when 8
        root_0 = @adaptor.create_flat_list


        # at line 682:4: reference ( 'is' )? 'in' set_value
        @state.following.push( TOKENS_FOLLOWING_reference_IN_constraint_statement_1975 )
        reference319 = reference
        @state.following.pop
        @adaptor.add_child( root_0, reference319.tree )

        # at line 682:14: ( 'is' )?
        alt_121 = 2
        look_121_0 = @input.peek( 1 )

        if ( look_121_0 == T__66 )
          alt_121 = 1
        end
        case alt_121
        when 1
          # at line 682:14: 'is'
          string_literal320 = match( T__66, TOKENS_FOLLOWING_T__66_IN_constraint_statement_1977 )
          tree_for_string_literal320 = @adaptor.create_with_payload( string_literal320 )
          @adaptor.add_child( root_0, tree_for_string_literal320 )



        end
        string_literal321 = match( T__64, TOKENS_FOLLOWING_T__64_IN_constraint_statement_1980 )
        tree_for_string_literal321 = @adaptor.create_with_payload( string_literal321 )
        @adaptor.add_child( root_0, tree_for_string_literal321 )


        @state.following.push( TOKENS_FOLLOWING_set_value_IN_constraint_statement_1982 )
        set_value322 = set_value
        @state.following.pop
        @adaptor.add_child( root_0, set_value322.tree )


        # --> action

        			c_or = { '_context' => 'constraint', '_type' => 'or', '_parent' => @now }
        			( set_value322.nil? ? nil : set_value322.val ).each { |v|
        				id = self.next_id.to_s
        				item = { '_context' => 'constraint', '_type' => 'and', '_parent' => c_or }
        				item[( reference319.nil? ? nil : reference319.val )] = { '_context' => 'constraint', '_type' => 'equals', '_value' => v }
        				c_or[id] = item
        			}
        			return_value.key = self.next_id.to_s
        			return_value.val = c_or
        		
        # <-- action


      when 9
        root_0 = @adaptor.create_flat_list


        # at line 694:4: reference ( 'isnot' | 'isnt' | 'not' ) 'in' set_value
        @state.following.push( TOKENS_FOLLOWING_reference_IN_constraint_statement_1991 )
        reference323 = reference
        @state.following.pop
        @adaptor.add_child( root_0, reference323.tree )


        set324 = @input.look

        if @input.peek( 1 ).between?( T__68, T__69 ) || @input.peek(1) == T__73
          @input.consume
          @adaptor.add_child( root_0, @adaptor.create_with_payload( set324 ) )

          @state.error_recovery = false

        else
          mse = MismatchedSet( nil )
          raise mse

        end


        string_literal325 = match( T__64, TOKENS_FOLLOWING_T__64_IN_constraint_statement_2001 )
        tree_for_string_literal325 = @adaptor.create_with_payload( string_literal325 )
        @adaptor.add_child( root_0, tree_for_string_literal325 )


        @state.following.push( TOKENS_FOLLOWING_set_value_IN_constraint_statement_2003 )
        set_value326 = set_value
        @state.following.pop
        @adaptor.add_child( root_0, set_value326.tree )


        # --> action

        			c_and = { '_context'=>'constraint', '_type'=>'and', '_parent'=>@now }
        			( set_value326.nil? ? nil : set_value326.val ).each { |v|
        				id = self.next_id.to_s
        				item = { '_context'=>'constraint', '_type'=>'and'}
        				item[( reference323.nil? ? nil : reference323.val )] = { '_context'=>'constraint', '_type'=>'not-equals', '_value'=>v }
        				c_and[id] = item
        			}
        			return_value.key = self.next_id.to_s
        			return_value.val = c_and

        			#return_value.key = ( reference323.nil? ? nil : reference323.val )
        			#return_value.val = { '_context' => 'constraint', '_type' => 'not-in', '_value' => ( set_value326.nil? ? nil : set_value326.val ) }
        		
        # <-- action


      when 10
        root_0 = @adaptor.create_flat_list


        # at line 709:4: reference 'has' value
        @state.following.push( TOKENS_FOLLOWING_reference_IN_constraint_statement_2012 )
        reference327 = reference
        @state.following.pop
        @adaptor.add_child( root_0, reference327.tree )

        string_literal328 = match( T__62, TOKENS_FOLLOWING_T__62_IN_constraint_statement_2014 )
        tree_for_string_literal328 = @adaptor.create_with_payload( string_literal328 )
        @adaptor.add_child( root_0, tree_for_string_literal328 )


        @state.following.push( TOKENS_FOLLOWING_value_IN_constraint_statement_2016 )
        value329 = value
        @state.following.pop
        @adaptor.add_child( root_0, value329.tree )


        # --> action

        			c_has = { '_context' => 'constraint',
        				'_type' => 'has',
        				'_parent' => @now,
        				'_owner' => ( reference327.nil? ? nil : reference327.val ),
        				'_value' => ( value329.nil? ? nil : value329.val )
        			}
        		
        # <-- action


      when 11
        root_0 = @adaptor.create_flat_list


        # at line 718:4: reference binary_comp comp_value
        @state.following.push( TOKENS_FOLLOWING_reference_IN_constraint_statement_2025 )
        reference330 = reference
        @state.following.pop
        @adaptor.add_child( root_0, reference330.tree )

        @state.following.push( TOKENS_FOLLOWING_binary_comp_IN_constraint_statement_2027 )
        binary_comp331 = binary_comp
        @state.following.pop
        @adaptor.add_child( root_0, binary_comp331.tree )

        @state.following.push( TOKENS_FOLLOWING_comp_value_IN_constraint_statement_2029 )
        comp_value332 = comp_value
        @state.following.pop
        @adaptor.add_child( root_0, comp_value332.tree )


        # --> action

        			return_value.key = ( reference330.nil? ? nil : reference330.val )
        			return_value.val = { '_context' => 'constraint', '_type' => ( binary_comp331 && @input.to_s( binary_comp331.start, binary_comp331.stop ) ), '_value' => ( comp_value332.nil? ? nil : comp_value332.val ) }
        		
        # <-- action


      when 12
        root_0 = @adaptor.create_flat_list


        # at line 723:4: total_constraint
        @state.following.push( TOKENS_FOLLOWING_total_constraint_IN_constraint_statement_2038 )
        total_constraint333 = total_constraint
        @state.following.pop
        @adaptor.add_child( root_0, total_constraint333.tree )


      end
      # - - - - - - - rule clean up - - - - - - - -
      return_value.stop = @input.look( -1 )


      return_value.tree = @adaptor.rule_post_processing( root_0 )
      @adaptor.set_token_boundaries( return_value.tree, return_value.start, return_value.stop )


      rescue ANTLR3::Error::RecognitionError => re
        report_error(re)
        recover(re)
        return_value.tree = @adaptor.create_error_node( @input, return_value.start, @input.look(-1), re )


      ensure
        # -> uncomment the next line to manually enable rule tracing
        # trace_out( __method__, 40 )


      end

      return return_value
    end

    TotalConstraintReturnValue = define_return_scope

    #
    # parser rule total_constraint
    #
    # (in SfpLang.g)
    # 726:1: total_constraint : 'total(' total_statement ')' binary_comp NUMBER ;
    #
    def total_constraint
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 41 )


      return_value = TotalConstraintReturnValue.new

      # $rule.start = the first token seen before matching
      return_value.start = @input.look


      root_0 = nil

      string_literal334 = nil
      char_literal336 = nil
      __NUMBER338__ = nil
      total_statement335 = nil
      binary_comp337 = nil


      tree_for_string_literal334 = nil
      tree_for_char_literal336 = nil
      tree_for_NUMBER338 = nil

      begin
      root_0 = @adaptor.create_flat_list


      # at line 727:4: 'total(' total_statement ')' binary_comp NUMBER
      string_literal334 = match( T__83, TOKENS_FOLLOWING_T__83_IN_total_constraint_2049 )
      tree_for_string_literal334 = @adaptor.create_with_payload( string_literal334 )
      @adaptor.add_child( root_0, tree_for_string_literal334 )


      @state.following.push( TOKENS_FOLLOWING_total_statement_IN_total_constraint_2051 )
      total_statement335 = total_statement
      @state.following.pop
      @adaptor.add_child( root_0, total_statement335.tree )

      char_literal336 = match( T__21, TOKENS_FOLLOWING_T__21_IN_total_constraint_2053 )
      tree_for_char_literal336 = @adaptor.create_with_payload( char_literal336 )
      @adaptor.add_child( root_0, tree_for_char_literal336 )


      @state.following.push( TOKENS_FOLLOWING_binary_comp_IN_total_constraint_2055 )
      binary_comp337 = binary_comp
      @state.following.pop
      @adaptor.add_child( root_0, binary_comp337.tree )

      __NUMBER338__ = match( NUMBER, TOKENS_FOLLOWING_NUMBER_IN_total_constraint_2057 )
      tree_for_NUMBER338 = @adaptor.create_with_payload( __NUMBER338__ )
      @adaptor.add_child( root_0, tree_for_NUMBER338 )



      # - - - - - - - rule clean up - - - - - - - -
      return_value.stop = @input.look( -1 )


      return_value.tree = @adaptor.rule_post_processing( root_0 )
      @adaptor.set_token_boundaries( return_value.tree, return_value.start, return_value.stop )


      rescue ANTLR3::Error::RecognitionError => re
        report_error(re)
        recover(re)
        return_value.tree = @adaptor.create_error_node( @input, return_value.start, @input.look(-1), re )


      ensure
        # -> uncomment the next line to manually enable rule tracing
        # trace_out( __method__, 41 )


      end

      return return_value
    end

    TotalStatementReturnValue = define_return_scope

    #
    # parser rule total_statement
    #
    # (in SfpLang.g)
    # 730:1: total_statement : reference equals_op value ;
    #
    def total_statement
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 42 )


      return_value = TotalStatementReturnValue.new

      # $rule.start = the first token seen before matching
      return_value.start = @input.look


      root_0 = nil

      reference339 = nil
      equals_op340 = nil
      value341 = nil



      begin
      root_0 = @adaptor.create_flat_list


      # at line 731:4: reference equals_op value
      @state.following.push( TOKENS_FOLLOWING_reference_IN_total_statement_2068 )
      reference339 = reference
      @state.following.pop
      @adaptor.add_child( root_0, reference339.tree )

      @state.following.push( TOKENS_FOLLOWING_equals_op_IN_total_statement_2070 )
      equals_op340 = equals_op
      @state.following.pop
      @adaptor.add_child( root_0, equals_op340.tree )

      @state.following.push( TOKENS_FOLLOWING_value_IN_total_statement_2072 )
      value341 = value
      @state.following.pop
      @adaptor.add_child( root_0, value341.tree )


      # - - - - - - - rule clean up - - - - - - - -
      return_value.stop = @input.look( -1 )


      return_value.tree = @adaptor.rule_post_processing( root_0 )
      @adaptor.set_token_boundaries( return_value.tree, return_value.start, return_value.stop )


      rescue ANTLR3::Error::RecognitionError => re
        report_error(re)
        recover(re)
        return_value.tree = @adaptor.create_error_node( @input, return_value.start, @input.look(-1), re )


      ensure
        # -> uncomment the next line to manually enable rule tracing
        # trace_out( __method__, 42 )


      end

      return return_value
    end

    CompValueReturnValue = define_return_scope :val

    #
    # parser rule comp_value
    #
    # (in SfpLang.g)
    # 734:1: comp_value returns [val] : ( NUMBER | reference );
    #
    def comp_value
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 43 )


      return_value = CompValueReturnValue.new

      # $rule.start = the first token seen before matching
      return_value.start = @input.look


      root_0 = nil

      __NUMBER342__ = nil
      reference343 = nil


      tree_for_NUMBER342 = nil

      begin
      # at line 735:2: ( NUMBER | reference )
      alt_123 = 2
      look_123_0 = @input.peek( 1 )

      if ( look_123_0 == NUMBER )
        alt_123 = 1
      elsif ( look_123_0 == ID )
        alt_123 = 2
      else
        raise NoViableAlternative( "", 123, 0 )

      end
      case alt_123
      when 1
        root_0 = @adaptor.create_flat_list


        # at line 735:4: NUMBER
        __NUMBER342__ = match( NUMBER, TOKENS_FOLLOWING_NUMBER_IN_comp_value_2087 )
        tree_for_NUMBER342 = @adaptor.create_with_payload( __NUMBER342__ )
        @adaptor.add_child( root_0, tree_for_NUMBER342 )



        # --> action
        	return_value.val = __NUMBER342__.text.to_i	
        # <-- action


      when 2
        root_0 = @adaptor.create_flat_list


        # at line 737:4: reference
        @state.following.push( TOKENS_FOLLOWING_reference_IN_comp_value_2096 )
        reference343 = reference
        @state.following.pop
        @adaptor.add_child( root_0, reference343.tree )


        # --> action
        	return_value.val = ( reference343.nil? ? nil : reference343.val )	
        # <-- action


      end
      # - - - - - - - rule clean up - - - - - - - -
      return_value.stop = @input.look( -1 )


      return_value.tree = @adaptor.rule_post_processing( root_0 )
      @adaptor.set_token_boundaries( return_value.tree, return_value.start, return_value.stop )


      rescue ANTLR3::Error::RecognitionError => re
        report_error(re)
        recover(re)
        return_value.tree = @adaptor.create_error_node( @input, return_value.start, @input.look(-1), re )


      ensure
        # -> uncomment the next line to manually enable rule tracing
        # trace_out( __method__, 43 )


      end

      return return_value
    end

    ConditionalConstraintReturnValue = define_return_scope :key, :val

    #
    # parser rule conditional_constraint
    #
    # (in SfpLang.g)
    # 741:1: conditional_constraint returns [key, val] : 'if' conditional_constraint_if_part conditional_constraint_then_part ;
    #
    def conditional_constraint
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 44 )


      return_value = ConditionalConstraintReturnValue.new

      # $rule.start = the first token seen before matching
      return_value.start = @input.look


      root_0 = nil

      string_literal344 = nil
      conditional_constraint_if_part345 = nil
      conditional_constraint_then_part346 = nil


      tree_for_string_literal344 = nil

      begin
      root_0 = @adaptor.create_flat_list


      # at line 742:4: 'if' conditional_constraint_if_part conditional_constraint_then_part
      string_literal344 = match( T__63, TOKENS_FOLLOWING_T__63_IN_conditional_constraint_2115 )
      tree_for_string_literal344 = @adaptor.create_with_payload( string_literal344 )
      @adaptor.add_child( root_0, tree_for_string_literal344 )



      # --> action

      			return_value.key = id = self.next_id.to_s
      			@now[id] = self.create_constraint(id, 'imply')
      			@now = @now[id]
      		
      # <-- action

      @state.following.push( TOKENS_FOLLOWING_conditional_constraint_if_part_IN_conditional_constraint_2123 )
      conditional_constraint_if_part345 = conditional_constraint_if_part
      @state.following.pop
      @adaptor.add_child( root_0, conditional_constraint_if_part345.tree )

      @state.following.push( TOKENS_FOLLOWING_conditional_constraint_then_part_IN_conditional_constraint_2127 )
      conditional_constraint_then_part346 = conditional_constraint_then_part
      @state.following.pop
      @adaptor.add_child( root_0, conditional_constraint_then_part346.tree )


      # --> action
      	return_value.val = self.goto_parent()	
      # <-- action


      # - - - - - - - rule clean up - - - - - - - -
      return_value.stop = @input.look( -1 )


      return_value.tree = @adaptor.rule_post_processing( root_0 )
      @adaptor.set_token_boundaries( return_value.tree, return_value.start, return_value.stop )


      rescue ANTLR3::Error::RecognitionError => re
        report_error(re)
        recover(re)
        return_value.tree = @adaptor.create_error_node( @input, return_value.start, @input.look(-1), re )


      ensure
        # -> uncomment the next line to manually enable rule tracing
        # trace_out( __method__, 44 )


      end

      return return_value
    end

    ConditionalConstraintIfPartReturnValue = define_return_scope

    #
    # parser rule conditional_constraint_if_part
    #
    # (in SfpLang.g)
    # 753:1: conditional_constraint_if_part : ( constraint_statement ( NL )* | '{' ( NL )+ constraint_body '}' ( NL )* );
    #
    def conditional_constraint_if_part
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 45 )


      return_value = ConditionalConstraintIfPartReturnValue.new

      # $rule.start = the first token seen before matching
      return_value.start = @input.look


      root_0 = nil

      __NL348__ = nil
      char_literal349 = nil
      __NL350__ = nil
      char_literal352 = nil
      __NL353__ = nil
      constraint_statement347 = nil
      constraint_body351 = nil


      tree_for_NL348 = nil
      tree_for_char_literal349 = nil
      tree_for_NL350 = nil
      tree_for_char_literal352 = nil
      tree_for_NL353 = nil

      begin
      # at line 754:2: ( constraint_statement ( NL )* | '{' ( NL )+ constraint_body '}' ( NL )* )
      alt_127 = 2
      look_127_0 = @input.peek( 1 )

      if ( look_127_0 == ID || look_127_0 == T__63 || look_127_0 == T__73 || look_127_0 == T__83 )
        alt_127 = 1
      elsif ( look_127_0 == T__85 )
        alt_127 = 2
      else
        raise NoViableAlternative( "", 127, 0 )

      end
      case alt_127
      when 1
        root_0 = @adaptor.create_flat_list


        # at line 754:4: constraint_statement ( NL )*
        @state.following.push( TOKENS_FOLLOWING_constraint_statement_IN_conditional_constraint_if_part_2142 )
        constraint_statement347 = constraint_statement
        @state.following.pop
        @adaptor.add_child( root_0, constraint_statement347.tree )

        # at line 754:25: ( NL )*
        while true # decision 124
          alt_124 = 2
          look_124_0 = @input.peek( 1 )

          if ( look_124_0 == NL )
            alt_124 = 1

          end
          case alt_124
          when 1
            # at line 754:25: NL
            __NL348__ = match( NL, TOKENS_FOLLOWING_NL_IN_conditional_constraint_if_part_2144 )
            tree_for_NL348 = @adaptor.create_with_payload( __NL348__ )
            @adaptor.add_child( root_0, tree_for_NL348 )



          else
            break # out of loop for decision 124
          end
        end # loop for decision 124


        # --> action

        			id = self.next_id
        			@now[id] = self.create_constraint(id, 'and')
        			@now[id]['_subtype'] = 'premise'
        			@now[id][( constraint_statement347.nil? ? nil : constraint_statement347.key )] = ( constraint_statement347.nil? ? nil : constraint_statement347.val )
        		
        # <-- action


      when 2
        root_0 = @adaptor.create_flat_list


        # at line 761:4: '{' ( NL )+ constraint_body '}' ( NL )*
        char_literal349 = match( T__85, TOKENS_FOLLOWING_T__85_IN_conditional_constraint_if_part_2154 )
        tree_for_char_literal349 = @adaptor.create_with_payload( char_literal349 )
        @adaptor.add_child( root_0, tree_for_char_literal349 )



        # --> action

        			id = self.next_id
        			@now[id] = self.create_constraint(id, 'and')
        			@now[id]['_subtype'] = 'premise'
        			@now = @now[id]
        		
        # <-- action

        # at file 768:3: ( NL )+
        match_count_125 = 0
        while true
          alt_125 = 2
          look_125_0 = @input.peek( 1 )

          if ( look_125_0 == NL )
            alt_125 = 1

          end
          case alt_125
          when 1
            # at line 768:3: NL
            __NL350__ = match( NL, TOKENS_FOLLOWING_NL_IN_conditional_constraint_if_part_2162 )
            tree_for_NL350 = @adaptor.create_with_payload( __NL350__ )
            @adaptor.add_child( root_0, tree_for_NL350 )



          else
            match_count_125 > 0 and break
            eee = EarlyExit(125)


            raise eee
          end
          match_count_125 += 1
        end


        @state.following.push( TOKENS_FOLLOWING_constraint_body_IN_conditional_constraint_if_part_2165 )
        constraint_body351 = constraint_body
        @state.following.pop
        @adaptor.add_child( root_0, constraint_body351.tree )

        char_literal352 = match( T__86, TOKENS_FOLLOWING_T__86_IN_conditional_constraint_if_part_2169 )
        tree_for_char_literal352 = @adaptor.create_with_payload( char_literal352 )
        @adaptor.add_child( root_0, tree_for_char_literal352 )


        # at line 769:7: ( NL )*
        while true # decision 126
          alt_126 = 2
          look_126_0 = @input.peek( 1 )

          if ( look_126_0 == NL )
            alt_126 = 1

          end
          case alt_126
          when 1
            # at line 769:7: NL
            __NL353__ = match( NL, TOKENS_FOLLOWING_NL_IN_conditional_constraint_if_part_2171 )
            tree_for_NL353 = @adaptor.create_with_payload( __NL353__ )
            @adaptor.add_child( root_0, tree_for_NL353 )



          else
            break # out of loop for decision 126
          end
        end # loop for decision 126


        # --> action
        	self.goto_parent() 
        # <-- action


      end
      # - - - - - - - rule clean up - - - - - - - -
      return_value.stop = @input.look( -1 )


      return_value.tree = @adaptor.rule_post_processing( root_0 )
      @adaptor.set_token_boundaries( return_value.tree, return_value.start, return_value.stop )


      rescue ANTLR3::Error::RecognitionError => re
        report_error(re)
        recover(re)
        return_value.tree = @adaptor.create_error_node( @input, return_value.start, @input.look(-1), re )


      ensure
        # -> uncomment the next line to manually enable rule tracing
        # trace_out( __method__, 45 )


      end

      return return_value
    end

    ConditionalConstraintThenPartReturnValue = define_return_scope

    #
    # parser rule conditional_constraint_then_part
    #
    # (in SfpLang.g)
    # 773:1: conditional_constraint_then_part : ( 'then' constraint_statement | 'then' '{' ( NL )+ constraint_body '}' );
    #
    def conditional_constraint_then_part
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 46 )


      return_value = ConditionalConstraintThenPartReturnValue.new

      # $rule.start = the first token seen before matching
      return_value.start = @input.look


      root_0 = nil

      string_literal354 = nil
      string_literal356 = nil
      char_literal357 = nil
      __NL358__ = nil
      char_literal360 = nil
      constraint_statement355 = nil
      constraint_body359 = nil


      tree_for_string_literal354 = nil
      tree_for_string_literal356 = nil
      tree_for_char_literal357 = nil
      tree_for_NL358 = nil
      tree_for_char_literal360 = nil

      begin
      # at line 774:2: ( 'then' constraint_statement | 'then' '{' ( NL )+ constraint_body '}' )
      alt_129 = 2
      look_129_0 = @input.peek( 1 )

      if ( look_129_0 == T__82 )
        look_129_1 = @input.peek( 2 )

        if ( look_129_1 == ID || look_129_1 == T__63 || look_129_1 == T__73 || look_129_1 == T__83 )
          alt_129 = 1
        elsif ( look_129_1 == T__85 )
          alt_129 = 2
        else
          raise NoViableAlternative( "", 129, 1 )

        end
      else
        raise NoViableAlternative( "", 129, 0 )

      end
      case alt_129
      when 1
        root_0 = @adaptor.create_flat_list


        # at line 774:4: 'then' constraint_statement
        string_literal354 = match( T__82, TOKENS_FOLLOWING_T__82_IN_conditional_constraint_then_part_2187 )
        tree_for_string_literal354 = @adaptor.create_with_payload( string_literal354 )
        @adaptor.add_child( root_0, tree_for_string_literal354 )


        @state.following.push( TOKENS_FOLLOWING_constraint_statement_IN_conditional_constraint_then_part_2189 )
        constraint_statement355 = constraint_statement
        @state.following.pop
        @adaptor.add_child( root_0, constraint_statement355.tree )


        # --> action

        			id = self.next_id
        			@now[id] = self.create_constraint(id, 'and')
        			@now[id]['_subtype'] = 'conclusion'
        			@now[id][( constraint_statement355.nil? ? nil : constraint_statement355.key )] = ( constraint_statement355.nil? ? nil : constraint_statement355.val )
        		
        # <-- action


      when 2
        root_0 = @adaptor.create_flat_list


        # at line 781:4: 'then' '{' ( NL )+ constraint_body '}'
        string_literal356 = match( T__82, TOKENS_FOLLOWING_T__82_IN_conditional_constraint_then_part_2198 )
        tree_for_string_literal356 = @adaptor.create_with_payload( string_literal356 )
        @adaptor.add_child( root_0, tree_for_string_literal356 )



        # --> action

        			id = self.next_id
        			@now[id] = self.create_constraint(id, 'and')
        			@now[id]['_subtype'] = 'conclusion'
        			@now = @now[id]
        		
        # <-- action

        char_literal357 = match( T__85, TOKENS_FOLLOWING_T__85_IN_conditional_constraint_then_part_2206 )
        tree_for_char_literal357 = @adaptor.create_with_payload( char_literal357 )
        @adaptor.add_child( root_0, tree_for_char_literal357 )


        # at file 788:7: ( NL )+
        match_count_128 = 0
        while true
          alt_128 = 2
          look_128_0 = @input.peek( 1 )

          if ( look_128_0 == NL )
            alt_128 = 1

          end
          case alt_128
          when 1
            # at line 788:7: NL
            __NL358__ = match( NL, TOKENS_FOLLOWING_NL_IN_conditional_constraint_then_part_2208 )
            tree_for_NL358 = @adaptor.create_with_payload( __NL358__ )
            @adaptor.add_child( root_0, tree_for_NL358 )



          else
            match_count_128 > 0 and break
            eee = EarlyExit(128)


            raise eee
          end
          match_count_128 += 1
        end


        @state.following.push( TOKENS_FOLLOWING_constraint_body_IN_conditional_constraint_then_part_2211 )
        constraint_body359 = constraint_body
        @state.following.pop
        @adaptor.add_child( root_0, constraint_body359.tree )

        char_literal360 = match( T__86, TOKENS_FOLLOWING_T__86_IN_conditional_constraint_then_part_2213 )
        tree_for_char_literal360 = @adaptor.create_with_payload( char_literal360 )
        @adaptor.add_child( root_0, tree_for_char_literal360 )



        # --> action
        	self.goto_parent()	
        # <-- action


      end
      # - - - - - - - rule clean up - - - - - - - -
      return_value.stop = @input.look( -1 )


      return_value.tree = @adaptor.rule_post_processing( root_0 )
      @adaptor.set_token_boundaries( return_value.tree, return_value.start, return_value.stop )


      rescue ANTLR3::Error::RecognitionError => re
        report_error(re)
        recover(re)
        return_value.tree = @adaptor.create_error_node( @input, return_value.start, @input.look(-1), re )


      ensure
        # -> uncomment the next line to manually enable rule tracing
        # trace_out( __method__, 46 )


      end

      return return_value
    end

    EffectBodyReturnValue = define_return_scope

    #
    # parser rule effect_body
    #
    # (in SfpLang.g)
    # 792:1: effect_body : ( ( mutation | mutation_iterator ) ( NL )+ )* ;
    #
    def effect_body
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 47 )


      return_value = EffectBodyReturnValue.new

      # $rule.start = the first token seen before matching
      return_value.start = @input.look


      root_0 = nil

      __NL363__ = nil
      mutation361 = nil
      mutation_iterator362 = nil


      tree_for_NL363 = nil

      begin
      root_0 = @adaptor.create_flat_list


      # at line 793:4: ( ( mutation | mutation_iterator ) ( NL )+ )*
      # at line 793:4: ( ( mutation | mutation_iterator ) ( NL )+ )*
      while true # decision 132
        alt_132 = 2
        look_132_0 = @input.peek( 1 )

        if ( look_132_0 == ID || look_132_0 == T__50 || look_132_0 == T__58 )
          alt_132 = 1

        end
        case alt_132
        when 1
          # at line 794:4: ( mutation | mutation_iterator ) ( NL )+
          # at line 794:4: ( mutation | mutation_iterator )
          alt_130 = 2
          look_130_0 = @input.peek( 1 )

          if ( look_130_0 == ID || look_130_0 == T__50 )
            alt_130 = 1
          elsif ( look_130_0 == T__58 )
            alt_130 = 2
          else
            raise NoViableAlternative( "", 130, 0 )

          end
          case alt_130
          when 1
            # at line 794:6: mutation
            @state.following.push( TOKENS_FOLLOWING_mutation_IN_effect_body_2235 )
            mutation361 = mutation
            @state.following.pop
            @adaptor.add_child( root_0, mutation361.tree )


            # --> action
            	@now[( mutation361.nil? ? nil : mutation361.key )] = ( mutation361.nil? ? nil : mutation361.val )	
            # <-- action


          when 2
            # at line 796:6: mutation_iterator
            @state.following.push( TOKENS_FOLLOWING_mutation_iterator_IN_effect_body_2248 )
            mutation_iterator362 = mutation_iterator
            @state.following.pop
            @adaptor.add_child( root_0, mutation_iterator362.tree )


          end
          # at file 798:3: ( NL )+
          match_count_131 = 0
          while true
            alt_131 = 2
            look_131_0 = @input.peek( 1 )

            if ( look_131_0 == NL )
              alt_131 = 1

            end
            case alt_131
            when 1
              # at line 798:3: NL
              __NL363__ = match( NL, TOKENS_FOLLOWING_NL_IN_effect_body_2257 )
              tree_for_NL363 = @adaptor.create_with_payload( __NL363__ )
              @adaptor.add_child( root_0, tree_for_NL363 )



            else
              match_count_131 > 0 and break
              eee = EarlyExit(131)


              raise eee
            end
            match_count_131 += 1
          end



        else
          break # out of loop for decision 132
        end
      end # loop for decision 132


      # - - - - - - - rule clean up - - - - - - - -
      return_value.stop = @input.look( -1 )


      return_value.tree = @adaptor.rule_post_processing( root_0 )
      @adaptor.set_token_boundaries( return_value.tree, return_value.start, return_value.stop )


      rescue ANTLR3::Error::RecognitionError => re
        report_error(re)
        recover(re)
        return_value.tree = @adaptor.create_error_node( @input, return_value.start, @input.look(-1), re )


      ensure
        # -> uncomment the next line to manually enable rule tracing
        # trace_out( __method__, 47 )


      end

      return return_value
    end

    MutationIteratorReturnValue = define_return_scope

    #
    # parser rule mutation_iterator
    #
    # (in SfpLang.g)
    # 801:1: mutation_iterator : 'foreach' path 'as' ID ( NL )* '{' ( NL )+ ( mutation ( NL )+ )* '}' ;
    #
    def mutation_iterator
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 48 )


      return_value = MutationIteratorReturnValue.new

      # $rule.start = the first token seen before matching
      return_value.start = @input.look


      root_0 = nil

      string_literal364 = nil
      string_literal366 = nil
      __ID367__ = nil
      __NL368__ = nil
      char_literal369 = nil
      __NL370__ = nil
      __NL372__ = nil
      char_literal373 = nil
      path365 = nil
      mutation371 = nil


      tree_for_string_literal364 = nil
      tree_for_string_literal366 = nil
      tree_for_ID367 = nil
      tree_for_NL368 = nil
      tree_for_char_literal369 = nil
      tree_for_NL370 = nil
      tree_for_NL372 = nil
      tree_for_char_literal373 = nil

      begin
      root_0 = @adaptor.create_flat_list


      # at line 802:4: 'foreach' path 'as' ID ( NL )* '{' ( NL )+ ( mutation ( NL )+ )* '}'
      string_literal364 = match( T__58, TOKENS_FOLLOWING_T__58_IN_mutation_iterator_2272 )
      tree_for_string_literal364 = @adaptor.create_with_payload( string_literal364 )
      @adaptor.add_child( root_0, tree_for_string_literal364 )


      @state.following.push( TOKENS_FOLLOWING_path_IN_mutation_iterator_2274 )
      path365 = path
      @state.following.pop
      @adaptor.add_child( root_0, path365.tree )

      string_literal366 = match( T__43, TOKENS_FOLLOWING_T__43_IN_mutation_iterator_2276 )
      tree_for_string_literal366 = @adaptor.create_with_payload( string_literal366 )
      @adaptor.add_child( root_0, tree_for_string_literal366 )


      __ID367__ = match( ID, TOKENS_FOLLOWING_ID_IN_mutation_iterator_2278 )
      tree_for_ID367 = @adaptor.create_with_payload( __ID367__ )
      @adaptor.add_child( root_0, tree_for_ID367 )


      # at line 802:27: ( NL )*
      while true # decision 133
        alt_133 = 2
        look_133_0 = @input.peek( 1 )

        if ( look_133_0 == NL )
          alt_133 = 1

        end
        case alt_133
        when 1
          # at line 802:27: NL
          __NL368__ = match( NL, TOKENS_FOLLOWING_NL_IN_mutation_iterator_2280 )
          tree_for_NL368 = @adaptor.create_with_payload( __NL368__ )
          @adaptor.add_child( root_0, tree_for_NL368 )



        else
          break # out of loop for decision 133
        end
      end # loop for decision 133

      char_literal369 = match( T__85, TOKENS_FOLLOWING_T__85_IN_mutation_iterator_2283 )
      tree_for_char_literal369 = @adaptor.create_with_payload( char_literal369 )
      @adaptor.add_child( root_0, tree_for_char_literal369 )


      # at file 802:35: ( NL )+
      match_count_134 = 0
      while true
        alt_134 = 2
        look_134_0 = @input.peek( 1 )

        if ( look_134_0 == NL )
          alt_134 = 1

        end
        case alt_134
        when 1
          # at line 802:35: NL
          __NL370__ = match( NL, TOKENS_FOLLOWING_NL_IN_mutation_iterator_2285 )
          tree_for_NL370 = @adaptor.create_with_payload( __NL370__ )
          @adaptor.add_child( root_0, tree_for_NL370 )



        else
          match_count_134 > 0 and break
          eee = EarlyExit(134)


          raise eee
        end
        match_count_134 += 1
      end



      # --> action

      			id = self.to_ref(( path365 && @input.to_s( path365.start, path365.stop ) ))
      			@now[id] = { '_parent' => @now,
      				'_context' => 'iterator',
      				'_self' => id,
      				'_variable' => __ID367__.text
      			}
      			@now = @now[id]
      		
      # <-- action

      # at line 812:3: ( mutation ( NL )+ )*
      while true # decision 136
        alt_136 = 2
        look_136_0 = @input.peek( 1 )

        if ( look_136_0 == ID || look_136_0 == T__50 )
          alt_136 = 1

        end
        case alt_136
        when 1
          # at line 812:4: mutation ( NL )+
          @state.following.push( TOKENS_FOLLOWING_mutation_IN_mutation_iterator_2295 )
          mutation371 = mutation
          @state.following.pop
          @adaptor.add_child( root_0, mutation371.tree )


          # --> action
          	@now[( mutation371.nil? ? nil : mutation371.key )] = ( mutation371.nil? ? nil : mutation371.val )	
          # <-- action

          # at file 814:3: ( NL )+
          match_count_135 = 0
          while true
            alt_135 = 2
            look_135_0 = @input.peek( 1 )

            if ( look_135_0 == NL )
              alt_135 = 1

            end
            case alt_135
            when 1
              # at line 814:3: NL
              __NL372__ = match( NL, TOKENS_FOLLOWING_NL_IN_mutation_iterator_2303 )
              tree_for_NL372 = @adaptor.create_with_payload( __NL372__ )
              @adaptor.add_child( root_0, tree_for_NL372 )



            else
              match_count_135 > 0 and break
              eee = EarlyExit(135)


              raise eee
            end
            match_count_135 += 1
          end



        else
          break # out of loop for decision 136
        end
      end # loop for decision 136

      char_literal373 = match( T__86, TOKENS_FOLLOWING_T__86_IN_mutation_iterator_2310 )
      tree_for_char_literal373 = @adaptor.create_with_payload( char_literal373 )
      @adaptor.add_child( root_0, tree_for_char_literal373 )



      # --> action
      	self.goto_parent()	
      # <-- action


      # - - - - - - - rule clean up - - - - - - - -
      return_value.stop = @input.look( -1 )


      return_value.tree = @adaptor.rule_post_processing( root_0 )
      @adaptor.set_token_boundaries( return_value.tree, return_value.start, return_value.stop )


      rescue ANTLR3::Error::RecognitionError => re
        report_error(re)
        recover(re)
        return_value.tree = @adaptor.create_error_node( @input, return_value.start, @input.look(-1), re )


      ensure
        # -> uncomment the next line to manually enable rule tracing
        # trace_out( __method__, 48 )


      end

      return return_value
    end

    MutationReturnValue = define_return_scope :key, :val

    #
    # parser rule mutation
    #
    # (in SfpLang.g)
    # 819:1: mutation returns [key, val] : ( reference equals_op value | reference equals_op NULL | reference binary_op NUMBER | reference 'is' 'new' path ( object_body )? | 'delete' path | reference 'add(' value ')' | reference 'remove(' value ')' );
    #
    def mutation
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 49 )


      return_value = MutationReturnValue.new

      # $rule.start = the first token seen before matching
      return_value.start = @input.look


      root_0 = nil

      __NULL379__ = nil
      __NUMBER382__ = nil
      string_literal384 = nil
      string_literal385 = nil
      string_literal388 = nil
      string_literal391 = nil
      char_literal393 = nil
      string_literal395 = nil
      char_literal397 = nil
      reference374 = nil
      equals_op375 = nil
      value376 = nil
      reference377 = nil
      equals_op378 = nil
      reference380 = nil
      binary_op381 = nil
      reference383 = nil
      path386 = nil
      object_body387 = nil
      path389 = nil
      reference390 = nil
      value392 = nil
      reference394 = nil
      value396 = nil


      tree_for_NULL379 = nil
      tree_for_NUMBER382 = nil
      tree_for_string_literal384 = nil
      tree_for_string_literal385 = nil
      tree_for_string_literal388 = nil
      tree_for_string_literal391 = nil
      tree_for_char_literal393 = nil
      tree_for_string_literal395 = nil
      tree_for_char_literal397 = nil

      begin
      # at line 820:2: ( reference equals_op value | reference equals_op NULL | reference binary_op NUMBER | reference 'is' 'new' path ( object_body )? | 'delete' path | reference 'add(' value ')' | reference 'remove(' value ')' )
      alt_138 = 7
      alt_138 = @dfa138.predict( @input )
      case alt_138
      when 1
        root_0 = @adaptor.create_flat_list


        # at line 820:4: reference equals_op value
        @state.following.push( TOKENS_FOLLOWING_reference_IN_mutation_2329 )
        reference374 = reference
        @state.following.pop
        @adaptor.add_child( root_0, reference374.tree )

        @state.following.push( TOKENS_FOLLOWING_equals_op_IN_mutation_2331 )
        equals_op375 = equals_op
        @state.following.pop
        @adaptor.add_child( root_0, equals_op375.tree )

        @state.following.push( TOKENS_FOLLOWING_value_IN_mutation_2333 )
        value376 = value
        @state.following.pop
        @adaptor.add_child( root_0, value376.tree )


        # --> action

        			return_value.key = ( reference374.nil? ? nil : reference374.val )
        			return_value.val = { '_context' => 'mutation',
        				'_type' => 'equals',
        				'_value' => ( value376.nil? ? nil : value376.val )
        			}
        		
        # <-- action


      when 2
        root_0 = @adaptor.create_flat_list


        # at line 828:4: reference equals_op NULL
        @state.following.push( TOKENS_FOLLOWING_reference_IN_mutation_2342 )
        reference377 = reference
        @state.following.pop
        @adaptor.add_child( root_0, reference377.tree )

        @state.following.push( TOKENS_FOLLOWING_equals_op_IN_mutation_2344 )
        equals_op378 = equals_op
        @state.following.pop
        @adaptor.add_child( root_0, equals_op378.tree )

        __NULL379__ = match( NULL, TOKENS_FOLLOWING_NULL_IN_mutation_2346 )
        tree_for_NULL379 = @adaptor.create_with_payload( __NULL379__ )
        @adaptor.add_child( root_0, tree_for_NULL379 )



        # --> action

        			return_value.key = ( reference377.nil? ? nil : reference377.val )
        			return_value.val = { '_context' => 'mutation',
        				'_type' => 'equals',
        				'_value' => self.null_value
        			}
        		
        # <-- action


      when 3
        root_0 = @adaptor.create_flat_list


        # at line 836:4: reference binary_op NUMBER
        @state.following.push( TOKENS_FOLLOWING_reference_IN_mutation_2355 )
        reference380 = reference
        @state.following.pop
        @adaptor.add_child( root_0, reference380.tree )

        @state.following.push( TOKENS_FOLLOWING_binary_op_IN_mutation_2357 )
        binary_op381 = binary_op
        @state.following.pop
        @adaptor.add_child( root_0, binary_op381.tree )

        __NUMBER382__ = match( NUMBER, TOKENS_FOLLOWING_NUMBER_IN_mutation_2359 )
        tree_for_NUMBER382 = @adaptor.create_with_payload( __NUMBER382__ )
        @adaptor.add_child( root_0, tree_for_NUMBER382 )



        # --> action

        			return_value.key = ( reference380.nil? ? nil : reference380.val )
        			return_value.val = { '_context' => 'mutation',
        				'_type' => ( binary_op381 && @input.to_s( binary_op381.start, binary_op381.stop ) ),
        				'_value' => __NUMBER382__.text.to_i
        			}
        		
        # <-- action


      when 4
        root_0 = @adaptor.create_flat_list


        # at line 844:4: reference 'is' 'new' path ( object_body )?
        @state.following.push( TOKENS_FOLLOWING_reference_IN_mutation_2368 )
        reference383 = reference
        @state.following.pop
        @adaptor.add_child( root_0, reference383.tree )

        string_literal384 = match( T__66, TOKENS_FOLLOWING_T__66_IN_mutation_2370 )
        tree_for_string_literal384 = @adaptor.create_with_payload( string_literal384 )
        @adaptor.add_child( root_0, tree_for_string_literal384 )


        string_literal385 = match( T__72, TOKENS_FOLLOWING_T__72_IN_mutation_2372 )
        tree_for_string_literal385 = @adaptor.create_with_payload( string_literal385 )
        @adaptor.add_child( root_0, tree_for_string_literal385 )


        @state.following.push( TOKENS_FOLLOWING_path_IN_mutation_2374 )
        path386 = path
        @state.following.pop
        @adaptor.add_child( root_0, path386.tree )


        # --> action

        			id = '_' + self.next_id
        			@now[id] = { '_self' => id,
        				'_context' => 'object',
        				'_isa' => self.to_ref(( path386 && @input.to_s( path386.start, path386.stop ) )),
        				'_parent' => @now
        			}
        			@now = @now[id]
        		
        # <-- action

        # at line 854:3: ( object_body )?
        alt_137 = 2
        look_137_0 = @input.peek( 1 )

        if ( look_137_0 == T__85 )
          alt_137 = 1
        end
        case alt_137
        when 1
          # at line 854:3: object_body
          @state.following.push( TOKENS_FOLLOWING_object_body_IN_mutation_2382 )
          object_body387 = object_body
          @state.following.pop
          @adaptor.add_child( root_0, object_body387.tree )


        end

        # --> action

        			n = self.goto_parent()
        			@now.delete(n['_self'])
        			return_value.key = ( reference383.nil? ? nil : reference383.val )
        			return_value.val = n
        		
        # <-- action


      when 5
        root_0 = @adaptor.create_flat_list


        # at line 861:4: 'delete' path
        string_literal388 = match( T__50, TOKENS_FOLLOWING_T__50_IN_mutation_2392 )
        tree_for_string_literal388 = @adaptor.create_with_payload( string_literal388 )
        @adaptor.add_child( root_0, tree_for_string_literal388 )


        @state.following.push( TOKENS_FOLLOWING_path_IN_mutation_2394 )
        path389 = path
        @state.following.pop
        @adaptor.add_child( root_0, path389.tree )


        # --> action

        			id = '_' + self.next_id
        			@now[id] = { '_self' => id,
        				'_context' => 'mutation',
        				'_type' => 'delete',
        				'_value' => self.to_ref(( path389 && @input.to_s( path389.start, path389.stop ) ))
        			}
        		
        # <-- action


      when 6
        root_0 = @adaptor.create_flat_list


        # at line 870:4: reference 'add(' value ')'
        @state.following.push( TOKENS_FOLLOWING_reference_IN_mutation_2403 )
        reference390 = reference
        @state.following.pop
        @adaptor.add_child( root_0, reference390.tree )

        string_literal391 = match( T__38, TOKENS_FOLLOWING_T__38_IN_mutation_2405 )
        tree_for_string_literal391 = @adaptor.create_with_payload( string_literal391 )
        @adaptor.add_child( root_0, tree_for_string_literal391 )


        @state.following.push( TOKENS_FOLLOWING_value_IN_mutation_2407 )
        value392 = value
        @state.following.pop
        @adaptor.add_child( root_0, value392.tree )

        char_literal393 = match( T__21, TOKENS_FOLLOWING_T__21_IN_mutation_2409 )
        tree_for_char_literal393 = @adaptor.create_with_payload( char_literal393 )
        @adaptor.add_child( root_0, tree_for_char_literal393 )



        # --> action

        			return_value.key = ( reference390.nil? ? nil : reference390.val )
        			return_value.val = { '_context' => 'mutation',
        				'_type' => 'add',
        				'_value' => ( value392.nil? ? nil : value392.val )
        			}
        		
        # <-- action


      when 7
        root_0 = @adaptor.create_flat_list


        # at line 878:4: reference 'remove(' value ')'
        @state.following.push( TOKENS_FOLLOWING_reference_IN_mutation_2418 )
        reference394 = reference
        @state.following.pop
        @adaptor.add_child( root_0, reference394.tree )

        string_literal395 = match( T__76, TOKENS_FOLLOWING_T__76_IN_mutation_2420 )
        tree_for_string_literal395 = @adaptor.create_with_payload( string_literal395 )
        @adaptor.add_child( root_0, tree_for_string_literal395 )


        @state.following.push( TOKENS_FOLLOWING_value_IN_mutation_2422 )
        value396 = value
        @state.following.pop
        @adaptor.add_child( root_0, value396.tree )

        char_literal397 = match( T__21, TOKENS_FOLLOWING_T__21_IN_mutation_2424 )
        tree_for_char_literal397 = @adaptor.create_with_payload( char_literal397 )
        @adaptor.add_child( root_0, tree_for_char_literal397 )



        # --> action

        			return_value.key = ( reference394.nil? ? nil : reference394.val )
        			return_value.val = { '_context' => 'mutation',
        				'_type' => 'remove',
        				'_value' => ( value396.nil? ? nil : value396.val )
        			}
        		
        # <-- action


      end
      # - - - - - - - rule clean up - - - - - - - -
      return_value.stop = @input.look( -1 )


      return_value.tree = @adaptor.rule_post_processing( root_0 )
      @adaptor.set_token_boundaries( return_value.tree, return_value.start, return_value.stop )


      rescue ANTLR3::Error::RecognitionError => re
        report_error(re)
        recover(re)
        return_value.tree = @adaptor.create_error_node( @input, return_value.start, @input.look(-1), re )


      ensure
        # -> uncomment the next line to manually enable rule tracing
        # trace_out( __method__, 49 )


      end

      return return_value
    end

    SetValueReturnValue = define_return_scope :val

    #
    # parser rule set_value
    #
    # (in SfpLang.g)
    # 888:1: set_value returns [val] : ( '(' | '[' ) ( set_item ( ',' ( NL )* set_item )* )? ( ')' | ']' ) ;
    #
    def set_value
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 50 )


      return_value = SetValueReturnValue.new

      # $rule.start = the first token seen before matching
      return_value.start = @input.look


      root_0 = nil

      set398 = nil
      char_literal400 = nil
      __NL401__ = nil
      set403 = nil
      set_item399 = nil
      set_item402 = nil


      tree_for_set398 = nil
      tree_for_char_literal400 = nil
      tree_for_NL401 = nil
      tree_for_set403 = nil

      begin
      root_0 = @adaptor.create_flat_list


      # at line 889:4: ( '(' | '[' ) ( set_item ( ',' ( NL )* set_item )* )? ( ')' | ']' )
      set398 = @input.look

      if @input.peek(1) == T__20 || @input.peek(1) == T__35
        @input.consume
        @adaptor.add_child( root_0, @adaptor.create_with_payload( set398 ) )

        @state.error_recovery = false

      else
        mse = MismatchedSet( nil )
        raise mse

      end



      # --> action
      	@set = Array.new	
      # <-- action

      # at line 891:3: ( set_item ( ',' ( NL )* set_item )* )?
      alt_141 = 2
      look_141_0 = @input.peek( 1 )

      if ( look_141_0 == BOOLEAN || look_141_0.between?( ID, MULTILINE_STRING ) || look_141_0 == NUMBER || look_141_0 == STRING || look_141_0 == T__20 || look_141_0 == T__35 || look_141_0 == T__41 )
        alt_141 = 1
      end
      case alt_141
      when 1
        # at line 891:4: set_item ( ',' ( NL )* set_item )*
        @state.following.push( TOKENS_FOLLOWING_set_item_IN_set_value_2456 )
        set_item399 = set_item
        @state.following.pop
        @adaptor.add_child( root_0, set_item399.tree )

        # at line 891:13: ( ',' ( NL )* set_item )*
        while true # decision 140
          alt_140 = 2
          look_140_0 = @input.peek( 1 )

          if ( look_140_0 == T__24 )
            alt_140 = 1

          end
          case alt_140
          when 1
            # at line 891:14: ',' ( NL )* set_item
            char_literal400 = match( T__24, TOKENS_FOLLOWING_T__24_IN_set_value_2459 )
            tree_for_char_literal400 = @adaptor.create_with_payload( char_literal400 )
            @adaptor.add_child( root_0, tree_for_char_literal400 )


            # at line 891:18: ( NL )*
            while true # decision 139
              alt_139 = 2
              look_139_0 = @input.peek( 1 )

              if ( look_139_0 == NL )
                alt_139 = 1

              end
              case alt_139
              when 1
                # at line 891:18: NL
                __NL401__ = match( NL, TOKENS_FOLLOWING_NL_IN_set_value_2461 )
                tree_for_NL401 = @adaptor.create_with_payload( __NL401__ )
                @adaptor.add_child( root_0, tree_for_NL401 )



              else
                break # out of loop for decision 139
              end
            end # loop for decision 139

            @state.following.push( TOKENS_FOLLOWING_set_item_IN_set_value_2464 )
            set_item402 = set_item
            @state.following.pop
            @adaptor.add_child( root_0, set_item402.tree )


          else
            break # out of loop for decision 140
          end
        end # loop for decision 140


      end

      # --> action
      	return_value.val = @set	
      # <-- action


      set403 = @input.look

      if @input.peek(1) == T__21 || @input.peek(1) == T__36
        @input.consume
        @adaptor.add_child( root_0, @adaptor.create_with_payload( set403 ) )

        @state.error_recovery = false

      else
        mse = MismatchedSet( nil )
        raise mse

      end



      # - - - - - - - rule clean up - - - - - - - -
      return_value.stop = @input.look( -1 )


      return_value.tree = @adaptor.rule_post_processing( root_0 )
      @adaptor.set_token_boundaries( return_value.tree, return_value.start, return_value.stop )


      rescue ANTLR3::Error::RecognitionError => re
        report_error(re)
        recover(re)
        return_value.tree = @adaptor.create_error_node( @input, return_value.start, @input.look(-1), re )


      ensure
        # -> uncomment the next line to manually enable rule tracing
        # trace_out( __method__, 50 )


      end

      return return_value
    end

    SetItemReturnValue = define_return_scope

    #
    # parser rule set_item
    #
    # (in SfpLang.g)
    # 896:1: set_item : value ;
    #
    def set_item
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 51 )


      return_value = SetItemReturnValue.new

      # $rule.start = the first token seen before matching
      return_value.start = @input.look


      root_0 = nil

      value404 = nil



      begin
      root_0 = @adaptor.create_flat_list


      # at line 897:4: value
      @state.following.push( TOKENS_FOLLOWING_value_IN_set_item_2491 )
      value404 = value
      @state.following.pop
      @adaptor.add_child( root_0, value404.tree )


      # --> action
      	@set.push(( value404.nil? ? nil : value404.val ))	
      # <-- action


      # - - - - - - - rule clean up - - - - - - - -
      return_value.stop = @input.look( -1 )


      return_value.tree = @adaptor.rule_post_processing( root_0 )
      @adaptor.set_token_boundaries( return_value.tree, return_value.start, return_value.stop )


      rescue ANTLR3::Error::RecognitionError => re
        report_error(re)
        recover(re)
        return_value.tree = @adaptor.create_error_node( @input, return_value.start, @input.look(-1), re )


      ensure
        # -> uncomment the next line to manually enable rule tracing
        # trace_out( __method__, 51 )


      end

      return return_value
    end

    ValueReturnValue = define_return_scope :val, :type

    #
    # parser rule value
    #
    # (in SfpLang.g)
    # 901:1: value returns [val, type] : ( primitive_value | reference | set_value | 'any' );
    #
    def value
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 52 )


      return_value = ValueReturnValue.new

      # $rule.start = the first token seen before matching
      return_value.start = @input.look


      root_0 = nil

      string_literal408 = nil
      primitive_value405 = nil
      reference406 = nil
      set_value407 = nil


      tree_for_string_literal408 = nil

      begin
      # at line 902:2: ( primitive_value | reference | set_value | 'any' )
      alt_142 = 4
      case look_142 = @input.peek( 1 )
      when BOOLEAN, MULTILINE_STRING, NUMBER, STRING then alt_142 = 1
      when ID then alt_142 = 2
      when T__20, T__35 then alt_142 = 3
      when T__41 then alt_142 = 4
      else
        raise NoViableAlternative( "", 142, 0 )

      end
      case alt_142
      when 1
        root_0 = @adaptor.create_flat_list


        # at line 902:4: primitive_value
        @state.following.push( TOKENS_FOLLOWING_primitive_value_IN_value_2510 )
        primitive_value405 = primitive_value
        @state.following.pop
        @adaptor.add_child( root_0, primitive_value405.tree )


        # --> action

        			return_value.val = ( primitive_value405.nil? ? nil : primitive_value405.val )
        			return_value.type = ( primitive_value405.nil? ? nil : primitive_value405.type )
        		
        # <-- action


      when 2
        root_0 = @adaptor.create_flat_list


        # at line 907:4: reference
        @state.following.push( TOKENS_FOLLOWING_reference_IN_value_2519 )
        reference406 = reference
        @state.following.pop
        @adaptor.add_child( root_0, reference406.tree )


        # --> action

        			return_value.val = ( reference406.nil? ? nil : reference406.val )
        			return_value.type = 'Reference'
        		
        # <-- action


      when 3
        root_0 = @adaptor.create_flat_list


        # at line 912:4: set_value
        @state.following.push( TOKENS_FOLLOWING_set_value_IN_value_2528 )
        set_value407 = set_value
        @state.following.pop
        @adaptor.add_child( root_0, set_value407.tree )


        # --> action

        			return_value.val = ( set_value407.nil? ? nil : set_value407.val )
        			return_value.type = 'Set'
        		
        # <-- action


      when 4
        root_0 = @adaptor.create_flat_list


        # at line 917:4: 'any'
        string_literal408 = match( T__41, TOKENS_FOLLOWING_T__41_IN_value_2537 )
        tree_for_string_literal408 = @adaptor.create_with_payload( string_literal408 )
        @adaptor.add_child( root_0, tree_for_string_literal408 )



        # --> action

        			return_value.val = Sfp::Any.new
        			return_value.type = 'Any'
        		
        # <-- action


      end
      # - - - - - - - rule clean up - - - - - - - -
      return_value.stop = @input.look( -1 )


      return_value.tree = @adaptor.rule_post_processing( root_0 )
      @adaptor.set_token_boundaries( return_value.tree, return_value.start, return_value.stop )


      rescue ANTLR3::Error::RecognitionError => re
        report_error(re)
        recover(re)
        return_value.tree = @adaptor.create_error_node( @input, return_value.start, @input.look(-1), re )


      ensure
        # -> uncomment the next line to manually enable rule tracing
        # trace_out( __method__, 52 )


      end

      return return_value
    end

    PrimitiveValueReturnValue = define_return_scope :val, :type

    #
    # parser rule primitive_value
    #
    # (in SfpLang.g)
    # 924:1: primitive_value returns [val, type] : ( BOOLEAN | NUMBER | STRING | MULTILINE_STRING );
    #
    def primitive_value
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 53 )


      return_value = PrimitiveValueReturnValue.new

      # $rule.start = the first token seen before matching
      return_value.start = @input.look


      root_0 = nil

      __BOOLEAN409__ = nil
      __NUMBER410__ = nil
      __STRING411__ = nil
      __MULTILINE_STRING412__ = nil


      tree_for_BOOLEAN409 = nil
      tree_for_NUMBER410 = nil
      tree_for_STRING411 = nil
      tree_for_MULTILINE_STRING412 = nil

      begin
      # at line 925:2: ( BOOLEAN | NUMBER | STRING | MULTILINE_STRING )
      alt_143 = 4
      case look_143 = @input.peek( 1 )
      when BOOLEAN then alt_143 = 1
      when NUMBER then alt_143 = 2
      when STRING then alt_143 = 3
      when MULTILINE_STRING then alt_143 = 4
      else
        raise NoViableAlternative( "", 143, 0 )

      end
      case alt_143
      when 1
        root_0 = @adaptor.create_flat_list


        # at line 925:4: BOOLEAN
        __BOOLEAN409__ = match( BOOLEAN, TOKENS_FOLLOWING_BOOLEAN_IN_primitive_value_2556 )
        tree_for_BOOLEAN409 = @adaptor.create_with_payload( __BOOLEAN409__ )
        @adaptor.add_child( root_0, tree_for_BOOLEAN409 )



        # --> action

        			if __BOOLEAN409__.text == 'true' or __BOOLEAN409__.text == 'on' or __BOOLEAN409__.text == 'yes'
        				return_value.val = true
        			else  # 'false', 'no', 'off'
        				return_value.val = false
        			end
        			return_value.type = 'Boolean'
        		
        # <-- action


      when 2
        root_0 = @adaptor.create_flat_list


        # at line 934:4: NUMBER
        __NUMBER410__ = match( NUMBER, TOKENS_FOLLOWING_NUMBER_IN_primitive_value_2565 )
        tree_for_NUMBER410 = @adaptor.create_with_payload( __NUMBER410__ )
        @adaptor.add_child( root_0, tree_for_NUMBER410 )



        # --> action

        			return_value.val = __NUMBER410__.text.to_i
        			return_value.type = 'Number'
        		
        # <-- action


      when 3
        root_0 = @adaptor.create_flat_list


        # at line 939:4: STRING
        __STRING411__ = match( STRING, TOKENS_FOLLOWING_STRING_IN_primitive_value_2574 )
        tree_for_STRING411 = @adaptor.create_with_payload( __STRING411__ )
        @adaptor.add_child( root_0, tree_for_STRING411 )



        # --> action

        			return_value.val = __STRING411__.text[1,__STRING411__.text.length-2]
        			return_value.type = 'String'
        		
        # <-- action


      when 4
        root_0 = @adaptor.create_flat_list


        # at line 944:4: MULTILINE_STRING
        __MULTILINE_STRING412__ = match( MULTILINE_STRING, TOKENS_FOLLOWING_MULTILINE_STRING_IN_primitive_value_2583 )
        tree_for_MULTILINE_STRING412 = @adaptor.create_with_payload( __MULTILINE_STRING412__ )
        @adaptor.add_child( root_0, tree_for_MULTILINE_STRING412 )



        # --> action

        			return_value.val = __MULTILINE_STRING412__.text[2, __MULTILINE_STRING412__.text.length-2]
        			return_value.type = 'String'
        		
        # <-- action


      end
      # - - - - - - - rule clean up - - - - - - - -
      return_value.stop = @input.look( -1 )


      return_value.tree = @adaptor.rule_post_processing( root_0 )
      @adaptor.set_token_boundaries( return_value.tree, return_value.start, return_value.stop )


      rescue ANTLR3::Error::RecognitionError => re
        report_error(re)
        recover(re)
        return_value.tree = @adaptor.create_error_node( @input, return_value.start, @input.look(-1), re )


      ensure
        # -> uncomment the next line to manually enable rule tracing
        # trace_out( __method__, 53 )


      end

      return return_value
    end

    PathReturnValue = define_return_scope

    #
    # parser rule path
    #
    # (in SfpLang.g)
    # 951:1: path : ID ( '.' ID )* ;
    #
    def path
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 54 )


      return_value = PathReturnValue.new

      # $rule.start = the first token seen before matching
      return_value.start = @input.look


      root_0 = nil

      __ID413__ = nil
      char_literal414 = nil
      __ID415__ = nil


      tree_for_ID413 = nil
      tree_for_char_literal414 = nil
      tree_for_ID415 = nil

      begin
      root_0 = @adaptor.create_flat_list


      # at line 952:4: ID ( '.' ID )*
      __ID413__ = match( ID, TOKENS_FOLLOWING_ID_IN_path_2598 )
      tree_for_ID413 = @adaptor.create_with_payload( __ID413__ )
      @adaptor.add_child( root_0, tree_for_ID413 )


      # at line 952:6: ( '.' ID )*
      while true # decision 144
        alt_144 = 2
        look_144_0 = @input.peek( 1 )

        if ( look_144_0 == T__26 )
          alt_144 = 1

        end
        case alt_144
        when 1
          # at line 952:7: '.' ID
          char_literal414 = match( T__26, TOKENS_FOLLOWING_T__26_IN_path_2600 )
          tree_for_char_literal414 = @adaptor.create_with_payload( char_literal414 )
          @adaptor.add_child( root_0, tree_for_char_literal414 )


          __ID415__ = match( ID, TOKENS_FOLLOWING_ID_IN_path_2601 )
          tree_for_ID415 = @adaptor.create_with_payload( __ID415__ )
          @adaptor.add_child( root_0, tree_for_ID415 )



        else
          break # out of loop for decision 144
        end
      end # loop for decision 144


      # - - - - - - - rule clean up - - - - - - - -
      return_value.stop = @input.look( -1 )


      return_value.tree = @adaptor.rule_post_processing( root_0 )
      @adaptor.set_token_boundaries( return_value.tree, return_value.start, return_value.stop )


      rescue ANTLR3::Error::RecognitionError => re
        report_error(re)
        recover(re)
        return_value.tree = @adaptor.create_error_node( @input, return_value.start, @input.look(-1), re )


      ensure
        # -> uncomment the next line to manually enable rule tracing
        # trace_out( __method__, 54 )


      end

      return return_value
    end

    PathWithIndexReturnValue = define_return_scope

    #
    # parser rule path_with_index
    #
    # (in SfpLang.g)
    # 955:1: path_with_index : id_ref ( '.' id_ref )* ;
    #
    def path_with_index
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 55 )


      return_value = PathWithIndexReturnValue.new

      # $rule.start = the first token seen before matching
      return_value.start = @input.look


      root_0 = nil

      char_literal417 = nil
      id_ref416 = nil
      id_ref418 = nil


      tree_for_char_literal417 = nil

      begin
      root_0 = @adaptor.create_flat_list


      # at line 956:4: id_ref ( '.' id_ref )*
      @state.following.push( TOKENS_FOLLOWING_id_ref_IN_path_with_index_2614 )
      id_ref416 = id_ref
      @state.following.pop
      @adaptor.add_child( root_0, id_ref416.tree )

      # at line 956:10: ( '.' id_ref )*
      while true # decision 145
        alt_145 = 2
        look_145_0 = @input.peek( 1 )

        if ( look_145_0 == T__26 )
          alt_145 = 1

        end
        case alt_145
        when 1
          # at line 956:11: '.' id_ref
          char_literal417 = match( T__26, TOKENS_FOLLOWING_T__26_IN_path_with_index_2616 )
          tree_for_char_literal417 = @adaptor.create_with_payload( char_literal417 )
          @adaptor.add_child( root_0, tree_for_char_literal417 )


          @state.following.push( TOKENS_FOLLOWING_id_ref_IN_path_with_index_2617 )
          id_ref418 = id_ref
          @state.following.pop
          @adaptor.add_child( root_0, id_ref418.tree )


        else
          break # out of loop for decision 145
        end
      end # loop for decision 145


      # - - - - - - - rule clean up - - - - - - - -
      return_value.stop = @input.look( -1 )


      return_value.tree = @adaptor.rule_post_processing( root_0 )
      @adaptor.set_token_boundaries( return_value.tree, return_value.start, return_value.stop )


      rescue ANTLR3::Error::RecognitionError => re
        report_error(re)
        recover(re)
        return_value.tree = @adaptor.create_error_node( @input, return_value.start, @input.look(-1), re )


      ensure
        # -> uncomment the next line to manually enable rule tracing
        # trace_out( __method__, 55 )


      end

      return return_value
    end

    IdRefReturnValue = define_return_scope

    #
    # parser rule id_ref
    #
    # (in SfpLang.g)
    # 959:1: id_ref : ID ( '[' NUMBER ']' )? ;
    #
    def id_ref
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 56 )


      return_value = IdRefReturnValue.new

      # $rule.start = the first token seen before matching
      return_value.start = @input.look


      root_0 = nil

      __ID419__ = nil
      char_literal420 = nil
      __NUMBER421__ = nil
      char_literal422 = nil


      tree_for_ID419 = nil
      tree_for_char_literal420 = nil
      tree_for_NUMBER421 = nil
      tree_for_char_literal422 = nil

      begin
      root_0 = @adaptor.create_flat_list


      # at line 960:4: ID ( '[' NUMBER ']' )?
      __ID419__ = match( ID, TOKENS_FOLLOWING_ID_IN_id_ref_2630 )
      tree_for_ID419 = @adaptor.create_with_payload( __ID419__ )
      @adaptor.add_child( root_0, tree_for_ID419 )


      # at line 960:6: ( '[' NUMBER ']' )?
      alt_146 = 2
      look_146_0 = @input.peek( 1 )

      if ( look_146_0 == T__35 )
        alt_146 = 1
      end
      case alt_146
      when 1
        # at line 960:7: '[' NUMBER ']'
        char_literal420 = match( T__35, TOKENS_FOLLOWING_T__35_IN_id_ref_2632 )
        tree_for_char_literal420 = @adaptor.create_with_payload( char_literal420 )
        @adaptor.add_child( root_0, tree_for_char_literal420 )


        __NUMBER421__ = match( NUMBER, TOKENS_FOLLOWING_NUMBER_IN_id_ref_2634 )
        tree_for_NUMBER421 = @adaptor.create_with_payload( __NUMBER421__ )
        @adaptor.add_child( root_0, tree_for_NUMBER421 )


        char_literal422 = match( T__36, TOKENS_FOLLOWING_T__36_IN_id_ref_2636 )
        tree_for_char_literal422 = @adaptor.create_with_payload( char_literal422 )
        @adaptor.add_child( root_0, tree_for_char_literal422 )



      end

      # - - - - - - - rule clean up - - - - - - - -
      return_value.stop = @input.look( -1 )


      return_value.tree = @adaptor.rule_post_processing( root_0 )
      @adaptor.set_token_boundaries( return_value.tree, return_value.start, return_value.stop )


      rescue ANTLR3::Error::RecognitionError => re
        report_error(re)
        recover(re)
        return_value.tree = @adaptor.create_error_node( @input, return_value.start, @input.look(-1), re )


      ensure
        # -> uncomment the next line to manually enable rule tracing
        # trace_out( __method__, 56 )


      end

      return return_value
    end

    ReferenceReturnValue = define_return_scope :val

    #
    # parser rule reference
    #
    # (in SfpLang.g)
    # 963:1: reference returns [val] : path_with_index ;
    #
    def reference
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 57 )


      return_value = ReferenceReturnValue.new

      # $rule.start = the first token seen before matching
      return_value.start = @input.look


      root_0 = nil

      path_with_index423 = nil



      begin
      root_0 = @adaptor.create_flat_list


      # at line 964:4: path_with_index
      @state.following.push( TOKENS_FOLLOWING_path_with_index_IN_reference_2653 )
      path_with_index423 = path_with_index
      @state.following.pop
      @adaptor.add_child( root_0, path_with_index423.tree )


      # --> action
      	return_value.val = self.to_ref(( path_with_index423 && @input.to_s( path_with_index423.start, path_with_index423.stop ) ))	
      # <-- action


      # - - - - - - - rule clean up - - - - - - - -
      return_value.stop = @input.look( -1 )


      return_value.tree = @adaptor.rule_post_processing( root_0 )
      @adaptor.set_token_boundaries( return_value.tree, return_value.start, return_value.stop )


      rescue ANTLR3::Error::RecognitionError => re
        report_error(re)
        recover(re)
        return_value.tree = @adaptor.create_error_node( @input, return_value.start, @input.look(-1), re )


      ensure
        # -> uncomment the next line to manually enable rule tracing
        # trace_out( __method__, 57 )


      end

      return return_value
    end

    ReferenceTypeReturnValue = define_return_scope :val

    #
    # parser rule reference_type
    #
    # (in SfpLang.g)
    # 968:1: reference_type returns [val] : 'isref' path ;
    #
    def reference_type
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 58 )


      return_value = ReferenceTypeReturnValue.new

      # $rule.start = the first token seen before matching
      return_value.start = @input.look


      root_0 = nil

      string_literal424 = nil
      path425 = nil


      tree_for_string_literal424 = nil

      begin
      root_0 = @adaptor.create_flat_list


      # at line 969:4: 'isref' path
      string_literal424 = match( T__70, TOKENS_FOLLOWING_T__70_IN_reference_type_2672 )
      tree_for_string_literal424 = @adaptor.create_with_payload( string_literal424 )
      @adaptor.add_child( root_0, tree_for_string_literal424 )


      @state.following.push( TOKENS_FOLLOWING_path_IN_reference_type_2674 )
      path425 = path
      @state.following.pop
      @adaptor.add_child( root_0, path425.tree )


      # --> action

      			return_value.val = { '_context' => 'null',
      				'_isa' => self.to_ref(( path425 && @input.to_s( path425.start, path425.stop ) ))
      			}
      		
      # <-- action


      # - - - - - - - rule clean up - - - - - - - -
      return_value.stop = @input.look( -1 )


      return_value.tree = @adaptor.rule_post_processing( root_0 )
      @adaptor.set_token_boundaries( return_value.tree, return_value.start, return_value.stop )


      rescue ANTLR3::Error::RecognitionError => re
        report_error(re)
        recover(re)
        return_value.tree = @adaptor.create_error_node( @input, return_value.start, @input.look(-1), re )


      ensure
        # -> uncomment the next line to manually enable rule tracing
        # trace_out( __method__, 58 )


      end

      return return_value
    end

    SetTypeReturnValue = define_return_scope :val

    #
    # parser rule set_type
    #
    # (in SfpLang.g)
    # 977:1: set_type returns [val] : 'isset' path ;
    #
    def set_type
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 59 )


      return_value = SetTypeReturnValue.new

      # $rule.start = the first token seen before matching
      return_value.start = @input.look


      root_0 = nil

      string_literal426 = nil
      path427 = nil


      tree_for_string_literal426 = nil

      begin
      root_0 = @adaptor.create_flat_list


      # at line 978:4: 'isset' path
      string_literal426 = match( T__71, TOKENS_FOLLOWING_T__71_IN_set_type_2693 )
      tree_for_string_literal426 = @adaptor.create_with_payload( string_literal426 )
      @adaptor.add_child( root_0, tree_for_string_literal426 )


      @state.following.push( TOKENS_FOLLOWING_path_IN_set_type_2695 )
      path427 = path
      @state.following.pop
      @adaptor.add_child( root_0, path427.tree )


      # --> action

      			return_value.val = { '_context' => 'set',
      				'_isa' => self.to_ref(( path427 && @input.to_s( path427.start, path427.stop ) )),
      				'_values' => []
      			}
      		
      # <-- action


      # - - - - - - - rule clean up - - - - - - - -
      return_value.stop = @input.look( -1 )


      return_value.tree = @adaptor.rule_post_processing( root_0 )
      @adaptor.set_token_boundaries( return_value.tree, return_value.start, return_value.stop )


      rescue ANTLR3::Error::RecognitionError => re
        report_error(re)
        recover(re)
        return_value.tree = @adaptor.create_error_node( @input, return_value.start, @input.look(-1), re )


      ensure
        # -> uncomment the next line to manually enable rule tracing
        # trace_out( __method__, 59 )


      end

      return return_value
    end

    ProbabilityOpReturnValue = define_return_scope

    #
    # parser rule probability_op
    #
    # (in SfpLang.g)
    # 987:1: probability_op : 'either' ;
    #
    def probability_op
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 60 )


      return_value = ProbabilityOpReturnValue.new

      # $rule.start = the first token seen before matching
      return_value.start = @input.look


      root_0 = nil

      string_literal428 = nil


      tree_for_string_literal428 = nil

      begin
      root_0 = @adaptor.create_flat_list


      # at line 988:4: 'either'
      string_literal428 = match( T__53, TOKENS_FOLLOWING_T__53_IN_probability_op_2710 )
      tree_for_string_literal428 = @adaptor.create_with_payload( string_literal428 )
      @adaptor.add_child( root_0, tree_for_string_literal428 )



      # - - - - - - - rule clean up - - - - - - - -
      return_value.stop = @input.look( -1 )


      return_value.tree = @adaptor.rule_post_processing( root_0 )
      @adaptor.set_token_boundaries( return_value.tree, return_value.start, return_value.stop )


      rescue ANTLR3::Error::RecognitionError => re
        report_error(re)
        recover(re)
        return_value.tree = @adaptor.create_error_node( @input, return_value.start, @input.look(-1), re )


      ensure
        # -> uncomment the next line to manually enable rule tracing
        # trace_out( __method__, 60 )


      end

      return return_value
    end

    EqualsOpReturnValue = define_return_scope

    #
    # parser rule equals_op
    #
    # (in SfpLang.g)
    # 991:1: equals_op : ( '=' | 'is' );
    #
    def equals_op
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 61 )


      return_value = EqualsOpReturnValue.new

      # $rule.start = the first token seen before matching
      return_value.start = @input.look


      root_0 = nil

      set429 = nil


      tree_for_set429 = nil

      begin
      root_0 = @adaptor.create_flat_list


      # at line 
      set429 = @input.look

      if @input.peek(1) == T__32 || @input.peek(1) == T__66
        @input.consume
        @adaptor.add_child( root_0, @adaptor.create_with_payload( set429 ) )

        @state.error_recovery = false

      else
        mse = MismatchedSet( nil )
        raise mse

      end



      # - - - - - - - rule clean up - - - - - - - -
      return_value.stop = @input.look( -1 )


      return_value.tree = @adaptor.rule_post_processing( root_0 )
      @adaptor.set_token_boundaries( return_value.tree, return_value.start, return_value.stop )


      rescue ANTLR3::Error::RecognitionError => re
        report_error(re)
        recover(re)
        return_value.tree = @adaptor.create_error_node( @input, return_value.start, @input.look(-1), re )


      ensure
        # -> uncomment the next line to manually enable rule tracing
        # trace_out( __method__, 61 )


      end

      return return_value
    end

    NotEqualsOpReturnValue = define_return_scope

    #
    # parser rule not_equals_op
    #
    # (in SfpLang.g)
    # 996:1: not_equals_op : ( '!=' | 'isnt' | 'isnot' );
    #
    def not_equals_op
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 62 )


      return_value = NotEqualsOpReturnValue.new

      # $rule.start = the first token seen before matching
      return_value.start = @input.look


      root_0 = nil

      set430 = nil


      tree_for_set430 = nil

      begin
      root_0 = @adaptor.create_flat_list


      # at line 
      set430 = @input.look

      if @input.peek(1) == T__19 || @input.peek( 1 ).between?( T__68, T__69 )
        @input.consume
        @adaptor.add_child( root_0, @adaptor.create_with_payload( set430 ) )

        @state.error_recovery = false

      else
        mse = MismatchedSet( nil )
        raise mse

      end



      # - - - - - - - rule clean up - - - - - - - -
      return_value.stop = @input.look( -1 )


      return_value.tree = @adaptor.rule_post_processing( root_0 )
      @adaptor.set_token_boundaries( return_value.tree, return_value.start, return_value.stop )


      rescue ANTLR3::Error::RecognitionError => re
        report_error(re)
        recover(re)
        return_value.tree = @adaptor.create_error_node( @input, return_value.start, @input.look(-1), re )


      ensure
        # -> uncomment the next line to manually enable rule tracing
        # trace_out( __method__, 62 )


      end

      return return_value
    end

    BinaryOpReturnValue = define_return_scope

    #
    # parser rule binary_op
    #
    # (in SfpLang.g)
    # 1002:1: binary_op : ( '+=' | '-=' | '*=' | '/=' );
    #
    def binary_op
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 63 )


      return_value = BinaryOpReturnValue.new

      # $rule.start = the first token seen before matching
      return_value.start = @input.look


      root_0 = nil

      set431 = nil


      tree_for_set431 = nil

      begin
      root_0 = @adaptor.create_flat_list


      # at line 
      set431 = @input.look

      if @input.peek( 1 ).between?( T__22, T__23 ) || @input.peek(1) == T__25 || @input.peek(1) == T__27
        @input.consume
        @adaptor.add_child( root_0, @adaptor.create_with_payload( set431 ) )

        @state.error_recovery = false

      else
        mse = MismatchedSet( nil )
        raise mse

      end



      # - - - - - - - rule clean up - - - - - - - -
      return_value.stop = @input.look( -1 )


      return_value.tree = @adaptor.rule_post_processing( root_0 )
      @adaptor.set_token_boundaries( return_value.tree, return_value.start, return_value.stop )


      rescue ANTLR3::Error::RecognitionError => re
        report_error(re)
        recover(re)
        return_value.tree = @adaptor.create_error_node( @input, return_value.start, @input.look(-1), re )


      ensure
        # -> uncomment the next line to manually enable rule tracing
        # trace_out( __method__, 63 )


      end

      return return_value
    end

    BinaryCompReturnValue = define_return_scope

    #
    # parser rule binary_comp
    #
    # (in SfpLang.g)
    # 1009:1: binary_comp : ( '>' | '>=' | '<' | '<=' );
    #
    def binary_comp
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 64 )


      return_value = BinaryCompReturnValue.new

      # $rule.start = the first token seen before matching
      return_value.start = @input.look


      root_0 = nil

      set432 = nil


      tree_for_set432 = nil

      begin
      root_0 = @adaptor.create_flat_list


      # at line 
      set432 = @input.look

      if @input.peek( 1 ).between?( T__30, T__31 ) || @input.peek( 1 ).between?( T__33, T__34 )
        @input.consume
        @adaptor.add_child( root_0, @adaptor.create_with_payload( set432 ) )

        @state.error_recovery = false

      else
        mse = MismatchedSet( nil )
        raise mse

      end



      # - - - - - - - rule clean up - - - - - - - -
      return_value.stop = @input.look( -1 )


      return_value.tree = @adaptor.rule_post_processing( root_0 )
      @adaptor.set_token_boundaries( return_value.tree, return_value.start, return_value.stop )


      rescue ANTLR3::Error::RecognitionError => re
        report_error(re)
        recover(re)
        return_value.tree = @adaptor.create_error_node( @input, return_value.start, @input.look(-1), re )


      ensure
        # -> uncomment the next line to manually enable rule tracing
        # trace_out( __method__, 64 )


      end

      return return_value
    end



    # - - - - - - - - - - DFA definitions - - - - - - - - - - -
    class DFA41 < ANTLR3::DFA
      EOT = unpack( 4, -1 )
      EOF = unpack( 1, -1, 1, 3, 2, -1 )
      MIN = unpack( 2, 11, 2, -1 )
      MAX = unpack( 2, 74, 2, -1 )
      ACCEPT = unpack( 2, -1, 1, 1, 1, 2 )
      SPECIAL = unpack( 4, -1 )
      TRANSITION = [
        unpack( 1, 1, 62, -1, 1, 2 ),
        unpack( 1, 1, 62, -1, 1, 2 ),
        unpack(  ),
        unpack(  )
      ].freeze

      ( 0 ... MIN.length ).zip( MIN, MAX ) do | i, a, z |
        if a > 0 and z < 0
          MAX[ i ] %= 0x10000
        end
      end

      @decision = 41


      def description
        <<-'__dfa_description__'.strip!
          ()* loopback of 283:3: ( ( NL )* 'or' ( NL )* '{' ( NL )* constraint_body '}' )*
        __dfa_description__
      end

    end
    class DFA75 < ANTLR3::DFA
      EOT = unpack( 9, -1 )
      EOF = unpack( 9, -1 )
      MIN = unpack( 1, 9, 1, 11, 3, -1, 2, 9, 1, -1, 1, 11 )
      MAX = unpack( 1, 83, 1, 85, 3, -1, 1, 9, 1, 86, 1, -1, 1, 85 )
      ACCEPT = unpack( 2, -1, 1, 1, 1, 3, 1, 4, 2, -1, 1, 2, 1, -1 )
      SPECIAL = unpack( 9, -1 )
      TRANSITION = [
        unpack( 1, 1, 44, -1, 1, 4, 2, -1, 1, 4, 1, 3, 1, 4, 3, -1, 1, 2, 
                9, -1, 1, 2, 9, -1, 1, 2 ),
        unpack( 1, 6, 7, -1, 1, 2, 6, -1, 1, 5, 3, -1, 6, 2, 26, -1, 1, 
                 2, 1, -1, 1, 2, 1, -1, 1, 2, 1, -1, 2, 2, 3, -1, 1, 2, 
                 11, -1, 1, 7 ),
        unpack(  ),
        unpack(  ),
        unpack(  ),
        unpack( 1, 8 ),
        unpack( 1, 2, 1, -1, 1, 6, 27, -1, 2, 2, 3, -1, 1, 2, 9, -1, 1, 
                 2, 2, -1, 4, 2, 2, -1, 1, 2, 9, -1, 1, 2, 4, -1, 1, 2, 
                 4, -1, 2, 2, 1, 7, 1, 2 ),
        unpack(  ),
        unpack( 1, 6, 7, -1, 1, 2, 6, -1, 1, 5, 3, -1, 6, 2, 26, -1, 1, 
                 2, 1, -1, 1, 2, 1, -1, 1, 2, 1, -1, 2, 2, 3, -1, 1, 2, 
                 11, -1, 1, 7 )
      ].freeze

      ( 0 ... MIN.length ).zip( MIN, MAX ) do | i, a, z |
        if a > 0 and z < 0
          MAX[ i ] %= 0x10000
        end
      end

      @decision = 75


      def description
        <<-'__dfa_description__'.strip!
          445:4: ( constraint_statement | constraint_namespace | constraint_iterator | constraint_class_quantification )
        __dfa_description__
      end

    end
    class DFA102 < ANTLR3::DFA
      EOT = unpack( 9, -1 )
      EOF = unpack( 9, -1 )
      MIN = unpack( 1, 9, 1, 11, 3, -1, 2, 9, 1, -1, 1, 11 )
      MAX = unpack( 1, 83, 1, 85, 3, -1, 1, 9, 1, 86, 1, -1, 1, 85 )
      ACCEPT = unpack( 2, -1, 1, 1, 1, 3, 1, 4, 2, -1, 1, 2, 1, -1 )
      SPECIAL = unpack( 9, -1 )
      TRANSITION = [
        unpack( 1, 1, 44, -1, 1, 4, 2, -1, 1, 4, 1, 3, 1, 4, 3, -1, 1, 2, 
                9, -1, 1, 2, 9, -1, 1, 2 ),
        unpack( 1, 6, 7, -1, 1, 2, 6, -1, 1, 5, 3, -1, 6, 2, 26, -1, 1, 
                 2, 1, -1, 1, 2, 1, -1, 1, 2, 1, -1, 2, 2, 3, -1, 1, 2, 
                 11, -1, 1, 7 ),
        unpack(  ),
        unpack(  ),
        unpack(  ),
        unpack( 1, 8 ),
        unpack( 1, 2, 1, -1, 1, 6, 42, -1, 1, 2, 2, -1, 3, 2, 3, -1, 1, 
                 2, 9, -1, 1, 2, 9, -1, 1, 2, 1, -1, 1, 7, 1, 2 ),
        unpack(  ),
        unpack( 1, 6, 7, -1, 1, 2, 6, -1, 1, 5, 3, -1, 6, 2, 26, -1, 1, 
                 2, 1, -1, 1, 2, 1, -1, 1, 2, 1, -1, 2, 2, 3, -1, 1, 2, 
                 11, -1, 1, 7 )
      ].freeze

      ( 0 ... MIN.length ).zip( MIN, MAX ) do | i, a, z |
        if a > 0 and z < 0
          MAX[ i ] %= 0x10000
        end
      end

      @decision = 102


      def description
        <<-'__dfa_description__'.strip!
          546:4: ( constraint_statement | constraint_namespace | constraint_iterator | constraint_class_quantification )
        __dfa_description__
      end

    end
    class DFA122 < ANTLR3::DFA
      EOT = unpack( 26, -1 )
      EOF = unpack( 26, -1 )
      MIN = unpack( 1, 9, 1, 11, 3, -1, 1, 13, 1, 9, 1, -1, 3, 4, 1, -1, 
                    1, 4, 3, -1, 1, 36, 1, 11, 4, -1, 1, 11, 1, 13, 1, 36, 
                    1, 11 )
      MAX = unpack( 1, 83, 1, 82, 3, -1, 1, 13, 1, 9, 1, -1, 2, 64, 1, 41, 
                    1, -1, 1, 41, 3, -1, 1, 36, 1, 82, 4, -1, 1, 82, 1, 
                    13, 1, 36, 1, 82 )
      ACCEPT = unpack( 2, -1, 1, 2, 1, 7, 1, 12, 2, -1, 1, 1, 3, -1, 1, 
                       8, 1, -1, 1, 9, 1, 10, 1, 11, 2, -1, 1, 3, 1, 4, 
                       1, 5, 1, 6, 4, -1 )
      SPECIAL = unpack( 26, -1 )
      TRANSITION = [
        unpack( 1, 1, 53, -1, 1, 3, 9, -1, 1, 2, 9, -1, 1, 4 ),
        unpack( 1, 7, 7, -1, 1, 12, 6, -1, 1, 6, 3, -1, 2, 15, 1, 10, 2, 
                 15, 1, 5, 26, -1, 1, 14, 1, -1, 1, 11, 1, -1, 1, 8, 1, 
                 -1, 2, 9, 3, -1, 1, 13, 8, -1, 1, 7 ),
        unpack(  ),
        unpack(  ),
        unpack(  ),
        unpack( 1, 16 ),
        unpack( 1, 17 ),
        unpack(  ),
        unpack( 1, 18, 4, -1, 2, 18, 1, -1, 1, 19, 1, 18, 1, -1, 1, 18, 
                 4, -1, 1, 18, 14, -1, 1, 18, 5, -1, 1, 18, 22, -1, 1, 11 ),
        unpack( 1, 20, 4, -1, 2, 20, 1, -1, 1, 21, 1, 20, 1, -1, 1, 20, 
                 4, -1, 1, 20, 14, -1, 1, 20, 5, -1, 1, 20, 22, -1, 1, 13 ),
        unpack( 1, 18, 4, -1, 2, 18, 1, -1, 1, 19, 1, 18, 1, -1, 1, 18, 
                 4, -1, 1, 18, 14, -1, 1, 18, 5, -1, 1, 18 ),
        unpack(  ),
        unpack( 1, 20, 4, -1, 2, 20, 1, -1, 1, 21, 1, 20, 1, -1, 1, 20, 
                 4, -1, 1, 20, 14, -1, 1, 20, 5, -1, 1, 20 ),
        unpack(  ),
        unpack(  ),
        unpack(  ),
        unpack( 1, 22 ),
        unpack( 1, 7, 7, -1, 1, 12, 6, -1, 1, 6, 3, -1, 2, 15, 1, 10, 2, 
                 15, 1, 23, 26, -1, 1, 14, 1, -1, 1, 11, 1, -1, 1, 8, 1, 
                 -1, 2, 9, 3, -1, 1, 13, 8, -1, 1, 7 ),
        unpack(  ),
        unpack(  ),
        unpack(  ),
        unpack(  ),
        unpack( 1, 7, 7, -1, 1, 12, 6, -1, 1, 6, 3, -1, 2, 15, 1, 10, 2, 
                 15, 27, -1, 1, 14, 1, -1, 1, 11, 1, -1, 1, 8, 1, -1, 2, 
                 9, 3, -1, 1, 13, 8, -1, 1, 7 ),
        unpack( 1, 24 ),
        unpack( 1, 25 ),
        unpack( 1, 7, 7, -1, 1, 12, 6, -1, 1, 6, 3, -1, 2, 15, 1, 10, 2, 
                 15, 27, -1, 1, 14, 1, -1, 1, 11, 1, -1, 1, 8, 1, -1, 2, 
                 9, 3, -1, 1, 13, 8, -1, 1, 7 )
      ].freeze

      ( 0 ... MIN.length ).zip( MIN, MAX ) do | i, a, z |
        if a > 0 and z < 0
          MAX[ i ] %= 0x10000
        end
      end

      @decision = 122


      def description
        <<-'__dfa_description__'.strip!
          646:1: constraint_statement returns [key, val] : ( reference | 'not' reference | reference equals_op value | reference equals_op NULL | reference not_equals_op value | reference not_equals_op NULL | conditional_constraint | reference ( 'is' )? 'in' set_value | reference ( 'isnot' | 'isnt' | 'not' ) 'in' set_value | reference 'has' value | reference binary_comp comp_value | total_constraint );
        __dfa_description__
      end

    end
    class DFA138 < ANTLR3::DFA
      EOT = unpack( 19, -1 )
      EOF = unpack( 19, -1 )
      MIN = unpack( 1, 9, 1, 22, 1, -1, 1, 13, 1, 9, 1, 4, 1, -1, 1, 4, 
                    2, -1, 1, 36, 1, 22, 3, -1, 1, 22, 1, 13, 1, 36, 1, 
                    22 )
      MAX = unpack( 1, 50, 1, 76, 1, -1, 1, 13, 1, 9, 1, 72, 1, -1, 1, 41, 
                    2, -1, 1, 36, 1, 76, 3, -1, 1, 76, 1, 13, 1, 36, 1, 
                    76 )
      ACCEPT = unpack( 2, -1, 1, 5, 3, -1, 1, 3, 1, -1, 1, 6, 1, 7, 2, -1, 
                       1, 4, 1, 1, 1, 2, 4, -1 )
      SPECIAL = unpack( 19, -1 )
      TRANSITION = [
        unpack( 1, 1, 40, -1, 1, 2 ),
        unpack( 2, 6, 1, -1, 1, 6, 1, 4, 1, 6, 4, -1, 1, 7, 2, -1, 1, 3, 
                 2, -1, 1, 8, 27, -1, 1, 5, 9, -1, 1, 9 ),
        unpack(  ),
        unpack( 1, 10 ),
        unpack( 1, 11 ),
        unpack( 1, 13, 4, -1, 2, 13, 1, -1, 1, 14, 1, 13, 1, -1, 1, 13, 
                 4, -1, 1, 13, 14, -1, 1, 13, 5, -1, 1, 13, 30, -1, 1, 12 ),
        unpack(  ),
        unpack( 1, 13, 4, -1, 2, 13, 1, -1, 1, 14, 1, 13, 1, -1, 1, 13, 
                 4, -1, 1, 13, 14, -1, 1, 13, 5, -1, 1, 13 ),
        unpack(  ),
        unpack(  ),
        unpack( 1, 15 ),
        unpack( 2, 6, 1, -1, 1, 6, 1, 4, 1, 6, 4, -1, 1, 7, 2, -1, 1, 16, 
                 2, -1, 1, 8, 27, -1, 1, 5, 9, -1, 1, 9 ),
        unpack(  ),
        unpack(  ),
        unpack(  ),
        unpack( 2, 6, 1, -1, 1, 6, 1, 4, 1, 6, 4, -1, 1, 7, 5, -1, 1, 8, 
                 27, -1, 1, 5, 9, -1, 1, 9 ),
        unpack( 1, 17 ),
        unpack( 1, 18 ),
        unpack( 2, 6, 1, -1, 1, 6, 1, 4, 1, 6, 4, -1, 1, 7, 5, -1, 1, 8, 
                 27, -1, 1, 5, 9, -1, 1, 9 )
      ].freeze

      ( 0 ... MIN.length ).zip( MIN, MAX ) do | i, a, z |
        if a > 0 and z < 0
          MAX[ i ] %= 0x10000
        end
      end

      @decision = 138


      def description
        <<-'__dfa_description__'.strip!
          819:1: mutation returns [key, val] : ( reference equals_op value | reference equals_op NULL | reference binary_op NUMBER | reference 'is' 'new' path ( object_body )? | 'delete' path | reference 'add(' value ')' | reference 'remove(' value ')' );
        __dfa_description__
      end

    end


    private

    def initialize_dfas
      super rescue nil
      @dfa41 = DFA41.new( self, 41 )


      @dfa75 = DFA75.new( self, 75 )


      @dfa102 = DFA102.new( self, 102 )


      @dfa122 = DFA122.new( self, 122 )


      @dfa138 = DFA138.new( self, 138 )


    end

    TOKENS_FOLLOWING_NL_IN_sfp_49 = Set[ 1, 9, 11, 18, 37, 40, 45, 60, 61, 65, 75, 77, 78, 80, 81 ]
    TOKENS_FOLLOWING_object_def_IN_sfp_57 = Set[ 1, 9, 11, 18, 37, 40, 45, 60, 61, 65, 75, 77, 78, 80, 81 ]
    TOKENS_FOLLOWING_abstract_object_IN_sfp_61 = Set[ 1, 9, 11, 18, 37, 40, 45, 60, 61, 65, 75, 77, 78, 80, 81 ]
    TOKENS_FOLLOWING_state_IN_sfp_65 = Set[ 1, 9, 11, 18, 37, 40, 45, 60, 61, 65, 75, 77, 78, 80, 81 ]
    TOKENS_FOLLOWING_constraint_def_IN_sfp_69 = Set[ 1, 9, 11, 18, 37, 40, 45, 60, 61, 65, 75, 77, 78, 80, 81 ]
    TOKENS_FOLLOWING_class_def_IN_sfp_73 = Set[ 1, 9, 11, 18, 37, 40, 45, 60, 61, 65, 75, 77, 78, 80, 81 ]
    TOKENS_FOLLOWING_procedure_IN_sfp_77 = Set[ 1, 9, 11, 18, 37, 40, 45, 60, 61, 65, 75, 77, 78, 80, 81 ]
    TOKENS_FOLLOWING_NL_IN_sfp_80 = Set[ 1, 9, 11, 18, 37, 40, 45, 60, 61, 65, 75, 77, 78, 80, 81 ]
    TOKENS_FOLLOWING_include_IN_sfp_87 = Set[ 1, 9, 18, 37, 40, 45, 60, 61, 65, 75, 77, 78, 80, 81 ]
    TOKENS_FOLLOWING_placement_IN_sfp_93 = Set[ 1, 9, 18, 37, 40, 45, 60, 61, 65, 75, 77, 78, 80, 81 ]
    TOKENS_FOLLOWING_T__18_IN_placement_113 = Set[ 9 ]
    TOKENS_FOLLOWING_path_IN_placement_115 = Set[ 28, 32, 53, 66, 70, 71 ]
    TOKENS_FOLLOWING_assignment_IN_placement_123 = Set[ 1 ]
    TOKENS_FOLLOWING_goal_constraint_IN_constraint_def_139 = Set[ 1 ]
    TOKENS_FOLLOWING_global_constraint_IN_constraint_def_144 = Set[ 1 ]
    TOKENS_FOLLOWING_sometime_constraint_IN_constraint_def_149 = Set[ 1 ]
    TOKENS_FOLLOWING_T__65_IN_include_160 = Set[ 15 ]
    TOKENS_FOLLOWING_include_file_IN_include_162 = Set[ 11 ]
    TOKENS_FOLLOWING_NL_IN_include_164 = Set[ 1, 11 ]
    TOKENS_FOLLOWING_STRING_IN_include_file_176 = Set[ 1 ]
    TOKENS_FOLLOWING_ID_IN_state_192 = Set[ 79 ]
    TOKENS_FOLLOWING_T__79_IN_state_194 = Set[ 11, 85 ]
    TOKENS_FOLLOWING_NL_IN_state_196 = Set[ 11, 85 ]
    TOKENS_FOLLOWING_T__85_IN_state_205 = Set[ 9, 11, 56, 86 ]
    TOKENS_FOLLOWING_NL_IN_state_207 = Set[ 9, 11, 56, 86 ]
    TOKENS_FOLLOWING_attribute_IN_state_212 = Set[ 9, 56, 86 ]
    TOKENS_FOLLOWING_T__86_IN_state_217 = Set[ 1 ]
    TOKENS_FOLLOWING_set_IN_class_def_232 = Set[ 9 ]
    TOKENS_FOLLOWING_ID_IN_class_def_238 = Set[ 1, 55, 85 ]
    TOKENS_FOLLOWING_extends_class_IN_class_def_247 = Set[ 1, 85 ]
    TOKENS_FOLLOWING_T__85_IN_class_def_261 = Set[ 9, 11, 56, 75, 80, 81, 86 ]
    TOKENS_FOLLOWING_NL_IN_class_def_263 = Set[ 9, 11, 56, 75, 80, 81, 86 ]
    TOKENS_FOLLOWING_attribute_IN_class_def_268 = Set[ 9, 56, 75, 80, 81, 86 ]
    TOKENS_FOLLOWING_procedure_IN_class_def_272 = Set[ 9, 11, 56, 75, 80, 81, 86 ]
    TOKENS_FOLLOWING_NL_IN_class_def_274 = Set[ 9, 11, 56, 75, 80, 81, 86 ]
    TOKENS_FOLLOWING_T__86_IN_class_def_280 = Set[ 1 ]
    TOKENS_FOLLOWING_T__55_IN_extends_class_302 = Set[ 9 ]
    TOKENS_FOLLOWING_path_IN_extends_class_304 = Set[ 1 ]
    TOKENS_FOLLOWING_T__56_IN_attribute_324 = Set[ 9 ]
    TOKENS_FOLLOWING_ID_IN_attribute_332 = Set[ 28, 32, 53, 66, 70, 71 ]
    TOKENS_FOLLOWING_assignment_IN_attribute_334 = Set[ 1 ]
    TOKENS_FOLLOWING_T__56_IN_attribute_349 = Set[ 9 ]
    TOKENS_FOLLOWING_object_def_IN_attribute_355 = Set[ 11 ]
    TOKENS_FOLLOWING_NL_IN_attribute_357 = Set[ 1, 11 ]
    TOKENS_FOLLOWING_equals_op_IN_assignment_370 = Set[ 4, 9, 10, 13, 15, 20, 35, 41 ]
    TOKENS_FOLLOWING_value_IN_assignment_372 = Set[ 11 ]
    TOKENS_FOLLOWING_NL_IN_assignment_374 = Set[ 1, 11 ]
    TOKENS_FOLLOWING_reference_type_IN_assignment_384 = Set[ 11 ]
    TOKENS_FOLLOWING_NL_IN_assignment_386 = Set[ 1, 11 ]
    TOKENS_FOLLOWING_set_type_IN_assignment_396 = Set[ 11 ]
    TOKENS_FOLLOWING_NL_IN_assignment_398 = Set[ 1, 11 ]
    TOKENS_FOLLOWING_probability_op_IN_assignment_408 = Set[ 20, 35 ]
    TOKENS_FOLLOWING_set_value_IN_assignment_410 = Set[ 11 ]
    TOKENS_FOLLOWING_NL_IN_assignment_412 = Set[ 1, 11 ]
    TOKENS_FOLLOWING_T__28_IN_assignment_422 = Set[ 9 ]
    TOKENS_FOLLOWING_path_IN_assignment_424 = Set[ 11 ]
    TOKENS_FOLLOWING_NL_IN_assignment_426 = Set[ 1, 11 ]
    TOKENS_FOLLOWING_path_IN_object_schema_442 = Set[ 1, 35 ]
    TOKENS_FOLLOWING_T__35_IN_object_schema_444 = Set[ 13 ]
    TOKENS_FOLLOWING_NUMBER_IN_object_schema_446 = Set[ 36 ]
    TOKENS_FOLLOWING_T__36_IN_object_schema_450 = Set[ 1 ]
    TOKENS_FOLLOWING_T__24_IN_object_schemata_467 = Set[ 9 ]
    TOKENS_FOLLOWING_object_schema_IN_object_schemata_469 = Set[ 1 ]
    TOKENS_FOLLOWING_T__37_IN_abstract_object_484 = Set[ 9 ]
    TOKENS_FOLLOWING_object_def_IN_abstract_object_486 = Set[ 1 ]
    TOKENS_FOLLOWING_ID_IN_object_def_505 = Set[ 1, 55, 67, 85 ]
    TOKENS_FOLLOWING_T__55_IN_object_def_516 = Set[ 9 ]
    TOKENS_FOLLOWING_path_IN_object_def_518 = Set[ 1, 67, 85 ]
    TOKENS_FOLLOWING_T__67_IN_object_def_536 = Set[ 9 ]
    TOKENS_FOLLOWING_object_schema_IN_object_def_538 = Set[ 1, 24, 85 ]
    TOKENS_FOLLOWING_object_schemata_IN_object_def_541 = Set[ 1, 24, 85 ]
    TOKENS_FOLLOWING_object_body_IN_object_def_550 = Set[ 1 ]
    TOKENS_FOLLOWING_T__85_IN_object_body_566 = Set[ 9, 11, 56, 75, 80, 81, 86 ]
    TOKENS_FOLLOWING_NL_IN_object_body_568 = Set[ 9, 11, 56, 75, 80, 81, 86 ]
    TOKENS_FOLLOWING_object_attribute_IN_object_body_573 = Set[ 9, 56, 75, 80, 81, 86 ]
    TOKENS_FOLLOWING_procedure_IN_object_body_577 = Set[ 9, 11, 56, 75, 80, 81, 86 ]
    TOKENS_FOLLOWING_NL_IN_object_body_579 = Set[ 9, 11, 56, 75, 80, 81, 86 ]
    TOKENS_FOLLOWING_T__86_IN_object_body_585 = Set[ 1 ]
    TOKENS_FOLLOWING_attribute_IN_object_attribute_596 = Set[ 1 ]
    TOKENS_FOLLOWING_ID_IN_object_attribute_601 = Set[ 32, 66 ]
    TOKENS_FOLLOWING_equals_op_IN_object_attribute_603 = Set[ 12 ]
    TOKENS_FOLLOWING_NULL_IN_object_attribute_605 = Set[ 11 ]
    TOKENS_FOLLOWING_NL_IN_object_attribute_607 = Set[ 1, 11 ]
    TOKENS_FOLLOWING_T__63_IN_state_dependency_623 = Set[ 9 ]
    TOKENS_FOLLOWING_dep_effect_IN_state_dependency_627 = Set[ 11, 82 ]
    TOKENS_FOLLOWING_NL_IN_state_dependency_629 = Set[ 11, 82 ]
    TOKENS_FOLLOWING_T__82_IN_state_dependency_632 = Set[ 11, 85 ]
    TOKENS_FOLLOWING_NL_IN_state_dependency_634 = Set[ 11, 85 ]
    TOKENS_FOLLOWING_T__85_IN_state_dependency_637 = Set[ 9, 11, 54, 57, 58, 59, 63, 73, 83, 86 ]
    TOKENS_FOLLOWING_NL_IN_state_dependency_641 = Set[ 9, 11, 54, 57, 58, 59, 63, 73, 83, 86 ]
    TOKENS_FOLLOWING_constraint_body_IN_state_dependency_644 = Set[ 86 ]
    TOKENS_FOLLOWING_T__86_IN_state_dependency_649 = Set[ 11, 74 ]
    TOKENS_FOLLOWING_NL_IN_state_dependency_655 = Set[ 11, 74 ]
    TOKENS_FOLLOWING_T__74_IN_state_dependency_658 = Set[ 11, 85 ]
    TOKENS_FOLLOWING_NL_IN_state_dependency_660 = Set[ 11, 85 ]
    TOKENS_FOLLOWING_T__85_IN_state_dependency_663 = Set[ 9, 11, 54, 57, 58, 59, 63, 73, 83, 86 ]
    TOKENS_FOLLOWING_NL_IN_state_dependency_667 = Set[ 9, 11, 54, 57, 58, 59, 63, 73, 83, 86 ]
    TOKENS_FOLLOWING_constraint_body_IN_state_dependency_670 = Set[ 86 ]
    TOKENS_FOLLOWING_T__86_IN_state_dependency_674 = Set[ 11, 74 ]
    TOKENS_FOLLOWING_NL_IN_state_dependency_680 = Set[ 1, 11 ]
    TOKENS_FOLLOWING_reference_IN_dep_effect_692 = Set[ 32, 66 ]
    TOKENS_FOLLOWING_equals_op_IN_dep_effect_694 = Set[ 4, 9, 10, 12, 13, 15, 20, 35, 41 ]
    TOKENS_FOLLOWING_value_IN_dep_effect_701 = Set[ 1 ]
    TOKENS_FOLLOWING_NULL_IN_dep_effect_707 = Set[ 1 ]
    TOKENS_FOLLOWING_ID_IN_op_param_723 = Set[ 32, 66 ]
    TOKENS_FOLLOWING_equals_op_IN_op_param_725 = Set[ 9 ]
    TOKENS_FOLLOWING_reference_IN_op_param_727 = Set[ 11 ]
    TOKENS_FOLLOWING_NL_IN_op_param_729 = Set[ 1, 11 ]
    TOKENS_FOLLOWING_set_IN_op_conditions_745 = Set[ 85 ]
    TOKENS_FOLLOWING_T__85_IN_op_conditions_753 = Set[ 9, 11, 86 ]
    TOKENS_FOLLOWING_NL_IN_op_conditions_755 = Set[ 9, 11, 86 ]
    TOKENS_FOLLOWING_op_statement_IN_op_conditions_764 = Set[ 9, 86 ]
    TOKENS_FOLLOWING_T__86_IN_op_conditions_769 = Set[ 11 ]
    TOKENS_FOLLOWING_NL_IN_op_conditions_771 = Set[ 1, 11 ]
    TOKENS_FOLLOWING_T__52_IN_op_effects_787 = Set[ 85 ]
    TOKENS_FOLLOWING_T__85_IN_op_effects_789 = Set[ 9, 11, 86 ]
    TOKENS_FOLLOWING_NL_IN_op_effects_791 = Set[ 9, 11, 86 ]
    TOKENS_FOLLOWING_op_statement_IN_op_effects_800 = Set[ 9, 86 ]
    TOKENS_FOLLOWING_T__86_IN_op_effects_805 = Set[ 11 ]
    TOKENS_FOLLOWING_NL_IN_op_effects_807 = Set[ 1, 11 ]
    TOKENS_FOLLOWING_reference_IN_op_statement_823 = Set[ 32, 66 ]
    TOKENS_FOLLOWING_equals_op_IN_op_statement_825 = Set[ 4, 9, 10, 13, 15, 20, 35, 41 ]
    TOKENS_FOLLOWING_value_IN_op_statement_827 = Set[ 11 ]
    TOKENS_FOLLOWING_NL_IN_op_statement_829 = Set[ 1, 11 ]
    TOKENS_FOLLOWING_T__81_IN_procedure_850 = Set[ 75, 80 ]
    TOKENS_FOLLOWING_set_IN_procedure_858 = Set[ 9 ]
    TOKENS_FOLLOWING_ID_IN_procedure_864 = Set[ 20, 85 ]
    TOKENS_FOLLOWING_parameters_IN_procedure_872 = Set[ 85 ]
    TOKENS_FOLLOWING_T__85_IN_procedure_875 = Set[ 11, 46, 47, 49, 51, 52 ]
    TOKENS_FOLLOWING_NL_IN_procedure_877 = Set[ 11, 46, 47, 49, 51, 52 ]
    TOKENS_FOLLOWING_T__49_IN_procedure_885 = Set[ 32, 66 ]
    TOKENS_FOLLOWING_equals_op_IN_procedure_887 = Set[ 13 ]
    TOKENS_FOLLOWING_NUMBER_IN_procedure_889 = Set[ 11 ]
    TOKENS_FOLLOWING_NL_IN_procedure_899 = Set[ 11, 46, 47, 51, 52 ]
    TOKENS_FOLLOWING_conditions_IN_procedure_909 = Set[ 51, 52 ]
    TOKENS_FOLLOWING_effects_IN_procedure_912 = Set[ 86 ]
    TOKENS_FOLLOWING_T__86_IN_procedure_914 = Set[ 1 ]
    TOKENS_FOLLOWING_T__20_IN_parameters_929 = Set[ 9 ]
    TOKENS_FOLLOWING_parameter_IN_parameters_931 = Set[ 21, 24 ]
    TOKENS_FOLLOWING_T__24_IN_parameters_934 = Set[ 9, 11 ]
    TOKENS_FOLLOWING_NL_IN_parameters_936 = Set[ 9, 11 ]
    TOKENS_FOLLOWING_parameter_IN_parameters_939 = Set[ 21, 24 ]
    TOKENS_FOLLOWING_T__21_IN_parameters_943 = Set[ 1 ]
    TOKENS_FOLLOWING_ID_IN_parameter_955 = Set[ 28 ]
    TOKENS_FOLLOWING_T__28_IN_parameter_957 = Set[ 9 ]
    TOKENS_FOLLOWING_path_IN_parameter_959 = Set[ 1 ]
    TOKENS_FOLLOWING_ID_IN_parameter_968 = Set[ 70 ]
    TOKENS_FOLLOWING_reference_type_IN_parameter_970 = Set[ 1 ]
    TOKENS_FOLLOWING_ID_IN_parameter_979 = Set[ 42 ]
    TOKENS_FOLLOWING_T__42_IN_parameter_981 = Set[ 9 ]
    TOKENS_FOLLOWING_path_IN_parameter_983 = Set[ 1 ]
    TOKENS_FOLLOWING_ID_IN_parameter_992 = Set[ 71 ]
    TOKENS_FOLLOWING_T__71_IN_parameter_994 = Set[ 9 ]
    TOKENS_FOLLOWING_path_IN_parameter_996 = Set[ 1 ]
    TOKENS_FOLLOWING_set_IN_conditions_1011 = Set[ 85 ]
    TOKENS_FOLLOWING_T__85_IN_conditions_1025 = Set[ 9, 11, 54, 57, 58, 59, 63, 73, 83, 86 ]
    TOKENS_FOLLOWING_NL_IN_conditions_1027 = Set[ 9, 11, 54, 57, 58, 59, 63, 73, 83, 86 ]
    TOKENS_FOLLOWING_constraint_body_IN_conditions_1030 = Set[ 86 ]
    TOKENS_FOLLOWING_T__86_IN_conditions_1032 = Set[ 11 ]
    TOKENS_FOLLOWING_NL_IN_conditions_1034 = Set[ 1, 11 ]
    TOKENS_FOLLOWING_set_IN_effects_1051 = Set[ 85 ]
    TOKENS_FOLLOWING_T__85_IN_effects_1065 = Set[ 9, 11, 50, 58, 86 ]
    TOKENS_FOLLOWING_NL_IN_effects_1067 = Set[ 9, 11, 50, 58, 86 ]
    TOKENS_FOLLOWING_effect_body_IN_effects_1073 = Set[ 86 ]
    TOKENS_FOLLOWING_T__86_IN_effects_1078 = Set[ 11 ]
    TOKENS_FOLLOWING_NL_IN_effects_1080 = Set[ 1, 11 ]
    TOKENS_FOLLOWING_T__61_IN_goal_constraint_1096 = Set[ 11, 48, 85 ]
    TOKENS_FOLLOWING_T__48_IN_goal_constraint_1098 = Set[ 11, 85 ]
    TOKENS_FOLLOWING_NL_IN_goal_constraint_1101 = Set[ 11, 85 ]
    TOKENS_FOLLOWING_T__85_IN_goal_constraint_1110 = Set[ 9, 11, 39, 40, 44, 54, 57, 58, 59, 60, 63, 73, 78, 83, 84, 86 ]
    TOKENS_FOLLOWING_NL_IN_goal_constraint_1112 = Set[ 9, 11, 39, 40, 44, 54, 57, 58, 59, 60, 63, 73, 78, 83, 84, 86 ]
    TOKENS_FOLLOWING_goal_body_IN_goal_constraint_1115 = Set[ 9, 39, 40, 44, 54, 57, 58, 59, 60, 63, 73, 78, 83, 84, 86 ]
    TOKENS_FOLLOWING_T__86_IN_goal_constraint_1118 = Set[ 1 ]
    TOKENS_FOLLOWING_set_IN_global_constraint_1133 = Set[ 11, 48, 85 ]
    TOKENS_FOLLOWING_T__48_IN_global_constraint_1139 = Set[ 11, 85 ]
    TOKENS_FOLLOWING_NL_IN_global_constraint_1142 = Set[ 11, 85 ]
    TOKENS_FOLLOWING_T__85_IN_global_constraint_1151 = Set[ 9, 11, 54, 57, 58, 59, 63, 73, 83, 86 ]
    TOKENS_FOLLOWING_NL_IN_global_constraint_1153 = Set[ 9, 11, 54, 57, 58, 59, 63, 73, 83, 86 ]
    TOKENS_FOLLOWING_constraint_body_IN_global_constraint_1156 = Set[ 86 ]
    TOKENS_FOLLOWING_T__86_IN_global_constraint_1158 = Set[ 1 ]
    TOKENS_FOLLOWING_T__78_IN_sometime_constraint_1173 = Set[ 11, 48, 85 ]
    TOKENS_FOLLOWING_T__48_IN_sometime_constraint_1175 = Set[ 11, 85 ]
    TOKENS_FOLLOWING_NL_IN_sometime_constraint_1178 = Set[ 11, 85 ]
    TOKENS_FOLLOWING_T__85_IN_sometime_constraint_1187 = Set[ 9, 11, 54, 57, 58, 59, 63, 73, 83, 86 ]
    TOKENS_FOLLOWING_NL_IN_sometime_constraint_1189 = Set[ 9, 11, 54, 57, 58, 59, 63, 73, 83, 86 ]
    TOKENS_FOLLOWING_constraint_body_IN_sometime_constraint_1192 = Set[ 86 ]
    TOKENS_FOLLOWING_T__86_IN_sometime_constraint_1194 = Set[ 1 ]
    TOKENS_FOLLOWING_constraint_statement_IN_goal_body_1217 = Set[ 11 ]
    TOKENS_FOLLOWING_constraint_namespace_IN_goal_body_1230 = Set[ 11 ]
    TOKENS_FOLLOWING_constraint_iterator_IN_goal_body_1237 = Set[ 11 ]
    TOKENS_FOLLOWING_constraint_class_quantification_IN_goal_body_1244 = Set[ 11 ]
    TOKENS_FOLLOWING_NL_IN_goal_body_1253 = Set[ 1, 11 ]
    TOKENS_FOLLOWING_set_IN_goal_body_1260 = Set[ 11, 85 ]
    TOKENS_FOLLOWING_NL_IN_goal_body_1266 = Set[ 11, 85 ]
    TOKENS_FOLLOWING_T__85_IN_goal_body_1275 = Set[ 9, 11, 54, 57, 58, 59, 63, 73, 83, 86 ]
    TOKENS_FOLLOWING_NL_IN_goal_body_1277 = Set[ 9, 11, 54, 57, 58, 59, 63, 73, 83, 86 ]
    TOKENS_FOLLOWING_constraint_body_IN_goal_body_1280 = Set[ 86 ]
    TOKENS_FOLLOWING_T__86_IN_goal_body_1282 = Set[ 11 ]
    TOKENS_FOLLOWING_NL_IN_goal_body_1284 = Set[ 1, 11 ]
    TOKENS_FOLLOWING_T__78_IN_goal_body_1294 = Set[ 11, 85 ]
    TOKENS_FOLLOWING_NL_IN_goal_body_1296 = Set[ 11, 85 ]
    TOKENS_FOLLOWING_T__85_IN_goal_body_1305 = Set[ 9, 11, 54, 57, 58, 59, 63, 73, 83, 86 ]
    TOKENS_FOLLOWING_NL_IN_goal_body_1307 = Set[ 9, 11, 54, 57, 58, 59, 63, 73, 83, 86 ]
    TOKENS_FOLLOWING_constraint_body_IN_goal_body_1310 = Set[ 86 ]
    TOKENS_FOLLOWING_T__86_IN_goal_body_1312 = Set[ 11 ]
    TOKENS_FOLLOWING_NL_IN_goal_body_1314 = Set[ 1, 11 ]
    TOKENS_FOLLOWING_T__84_IN_goal_body_1328 = Set[ 13 ]
    TOKENS_FOLLOWING_NUMBER_IN_goal_body_1330 = Set[ 11, 85 ]
    TOKENS_FOLLOWING_NL_IN_goal_body_1332 = Set[ 11, 85 ]
    TOKENS_FOLLOWING_T__85_IN_goal_body_1341 = Set[ 9, 11, 54, 57, 58, 59, 63, 73, 83, 86 ]
    TOKENS_FOLLOWING_NL_IN_goal_body_1343 = Set[ 9, 11, 54, 57, 58, 59, 63, 73, 83, 86 ]
    TOKENS_FOLLOWING_constraint_body_IN_goal_body_1346 = Set[ 86 ]
    TOKENS_FOLLOWING_T__86_IN_goal_body_1348 = Set[ 11 ]
    TOKENS_FOLLOWING_NL_IN_goal_body_1350 = Set[ 1, 11 ]
    TOKENS_FOLLOWING_T__39_IN_goal_body_1360 = Set[ 11, 85 ]
    TOKENS_FOLLOWING_NL_IN_goal_body_1362 = Set[ 11, 85 ]
    TOKENS_FOLLOWING_T__85_IN_goal_body_1371 = Set[ 9, 11, 54, 57, 58, 59, 63, 73, 83, 86 ]
    TOKENS_FOLLOWING_NL_IN_goal_body_1373 = Set[ 9, 11, 54, 57, 58, 59, 63, 73, 83, 86 ]
    TOKENS_FOLLOWING_constraint_body_IN_goal_body_1376 = Set[ 86 ]
    TOKENS_FOLLOWING_T__86_IN_goal_body_1378 = Set[ 11, 82, 84 ]
    TOKENS_FOLLOWING_NL_IN_goal_body_1380 = Set[ 11, 82, 84 ]
    TOKENS_FOLLOWING_T__82_IN_goal_body_1391 = Set[ 11, 85 ]
    TOKENS_FOLLOWING_T__84_IN_goal_body_1398 = Set[ 13 ]
    TOKENS_FOLLOWING_NUMBER_IN_goal_body_1400 = Set[ 11, 85 ]
    TOKENS_FOLLOWING_NL_IN_goal_body_1412 = Set[ 11, 85 ]
    TOKENS_FOLLOWING_T__85_IN_goal_body_1421 = Set[ 9, 11, 54, 57, 58, 59, 63, 73, 83, 86 ]
    TOKENS_FOLLOWING_NL_IN_goal_body_1423 = Set[ 9, 11, 54, 57, 58, 59, 63, 73, 83, 86 ]
    TOKENS_FOLLOWING_constraint_body_IN_goal_body_1426 = Set[ 86 ]
    TOKENS_FOLLOWING_T__86_IN_goal_body_1428 = Set[ 11 ]
    TOKENS_FOLLOWING_NL_IN_goal_body_1430 = Set[ 1, 11 ]
    TOKENS_FOLLOWING_T__44_IN_goal_body_1448 = Set[ 11, 85 ]
    TOKENS_FOLLOWING_NL_IN_goal_body_1450 = Set[ 11, 85 ]
    TOKENS_FOLLOWING_T__85_IN_goal_body_1459 = Set[ 9, 11, 54, 57, 58, 59, 63, 73, 83, 86 ]
    TOKENS_FOLLOWING_NL_IN_goal_body_1461 = Set[ 9, 11, 54, 57, 58, 59, 63, 73, 83, 86 ]
    TOKENS_FOLLOWING_constraint_body_IN_goal_body_1464 = Set[ 86 ]
    TOKENS_FOLLOWING_T__86_IN_goal_body_1466 = Set[ 11, 82 ]
    TOKENS_FOLLOWING_NL_IN_goal_body_1468 = Set[ 11, 82 ]
    TOKENS_FOLLOWING_T__82_IN_goal_body_1477 = Set[ 11, 85 ]
    TOKENS_FOLLOWING_NL_IN_goal_body_1479 = Set[ 11, 85 ]
    TOKENS_FOLLOWING_T__85_IN_goal_body_1488 = Set[ 9, 11, 54, 57, 58, 59, 63, 73, 83, 86 ]
    TOKENS_FOLLOWING_NL_IN_goal_body_1490 = Set[ 9, 11, 54, 57, 58, 59, 63, 73, 83, 86 ]
    TOKENS_FOLLOWING_constraint_body_IN_goal_body_1493 = Set[ 86 ]
    TOKENS_FOLLOWING_T__86_IN_goal_body_1495 = Set[ 11 ]
    TOKENS_FOLLOWING_NL_IN_goal_body_1497 = Set[ 1, 11 ]
    TOKENS_FOLLOWING_T__85_IN_nested_constraint_1517 = Set[ 9, 11, 54, 57, 58, 59, 63, 73, 83, 86 ]
    TOKENS_FOLLOWING_NL_IN_nested_constraint_1519 = Set[ 9, 11, 54, 57, 58, 59, 63, 73, 83, 86 ]
    TOKENS_FOLLOWING_constraint_body_IN_nested_constraint_1522 = Set[ 86 ]
    TOKENS_FOLLOWING_T__86_IN_nested_constraint_1524 = Set[ 1 ]
    TOKENS_FOLLOWING_T__48_IN_constraint_1535 = Set[ 9 ]
    TOKENS_FOLLOWING_ID_IN_constraint_1537 = Set[ 85 ]
    TOKENS_FOLLOWING_T__85_IN_constraint_1545 = Set[ 9, 11, 54, 57, 58, 59, 63, 73, 83, 86 ]
    TOKENS_FOLLOWING_NL_IN_constraint_1547 = Set[ 9, 11, 54, 57, 58, 59, 63, 73, 83, 86 ]
    TOKENS_FOLLOWING_constraint_body_IN_constraint_1550 = Set[ 86 ]
    TOKENS_FOLLOWING_T__86_IN_constraint_1552 = Set[ 1 ]
    TOKENS_FOLLOWING_constraint_statement_IN_constraint_body_1574 = Set[ 11 ]
    TOKENS_FOLLOWING_constraint_namespace_IN_constraint_body_1587 = Set[ 11 ]
    TOKENS_FOLLOWING_constraint_iterator_IN_constraint_body_1594 = Set[ 11 ]
    TOKENS_FOLLOWING_constraint_class_quantification_IN_constraint_body_1601 = Set[ 11 ]
    TOKENS_FOLLOWING_NL_IN_constraint_body_1610 = Set[ 1, 9, 11, 54, 57, 58, 59, 63, 73, 83 ]
    TOKENS_FOLLOWING_path_IN_constraint_namespace_1624 = Set[ 11, 85 ]
    TOKENS_FOLLOWING_NL_IN_constraint_namespace_1626 = Set[ 11, 85 ]
    TOKENS_FOLLOWING_T__85_IN_constraint_namespace_1629 = Set[ 9, 11, 63, 73, 83, 86 ]
    TOKENS_FOLLOWING_NL_IN_constraint_namespace_1631 = Set[ 9, 11, 63, 73, 83, 86 ]
    TOKENS_FOLLOWING_constraint_statement_IN_constraint_namespace_1635 = Set[ 11 ]
    TOKENS_FOLLOWING_NL_IN_constraint_namespace_1643 = Set[ 9, 11, 63, 73, 83, 86 ]
    TOKENS_FOLLOWING_T__86_IN_constraint_namespace_1648 = Set[ 1 ]
    TOKENS_FOLLOWING_T__58_IN_constraint_iterator_1659 = Set[ 20 ]
    TOKENS_FOLLOWING_T__20_IN_constraint_iterator_1661 = Set[ 9 ]
    TOKENS_FOLLOWING_path_IN_constraint_iterator_1663 = Set[ 43 ]
    TOKENS_FOLLOWING_T__43_IN_constraint_iterator_1665 = Set[ 9 ]
    TOKENS_FOLLOWING_ID_IN_constraint_iterator_1667 = Set[ 21 ]
    TOKENS_FOLLOWING_T__21_IN_constraint_iterator_1669 = Set[ 11, 85 ]
    TOKENS_FOLLOWING_NL_IN_constraint_iterator_1671 = Set[ 11, 85 ]
    TOKENS_FOLLOWING_T__85_IN_constraint_iterator_1674 = Set[ 11 ]
    TOKENS_FOLLOWING_NL_IN_constraint_iterator_1676 = Set[ 9, 11, 63, 73, 83, 86 ]
    TOKENS_FOLLOWING_constraint_statement_IN_constraint_iterator_1686 = Set[ 11 ]
    TOKENS_FOLLOWING_NL_IN_constraint_iterator_1694 = Set[ 9, 11, 63, 73, 83, 86 ]
    TOKENS_FOLLOWING_T__86_IN_constraint_iterator_1701 = Set[ 1 ]
    TOKENS_FOLLOWING_quantification_keyword_IN_constraint_class_quantification_1737 = Set[ 20 ]
    TOKENS_FOLLOWING_T__20_IN_constraint_class_quantification_1739 = Set[ 9 ]
    TOKENS_FOLLOWING_path_IN_constraint_class_quantification_1741 = Set[ 43 ]
    TOKENS_FOLLOWING_T__43_IN_constraint_class_quantification_1743 = Set[ 9 ]
    TOKENS_FOLLOWING_ID_IN_constraint_class_quantification_1745 = Set[ 21 ]
    TOKENS_FOLLOWING_T__21_IN_constraint_class_quantification_1747 = Set[ 11, 30, 31, 32, 33, 34, 85 ]
    TOKENS_FOLLOWING_binary_comp_IN_constraint_class_quantification_1759 = Set[ 13 ]
    TOKENS_FOLLOWING_T__32_IN_constraint_class_quantification_1772 = Set[ 13 ]
    TOKENS_FOLLOWING_NUMBER_IN_constraint_class_quantification_1788 = Set[ 11, 85 ]
    TOKENS_FOLLOWING_NL_IN_constraint_class_quantification_1802 = Set[ 11, 85 ]
    TOKENS_FOLLOWING_T__85_IN_constraint_class_quantification_1805 = Set[ 11 ]
    TOKENS_FOLLOWING_NL_IN_constraint_class_quantification_1807 = Set[ 9, 11, 29, 58, 63, 73, 83, 86 ]
    TOKENS_FOLLOWING_constraint_statement_IN_constraint_class_quantification_1814 = Set[ 11 ]
    TOKENS_FOLLOWING_NL_IN_constraint_class_quantification_1824 = Set[ 9, 11, 29, 58, 63, 73, 83, 86 ]
    TOKENS_FOLLOWING_constraint_different_IN_constraint_class_quantification_1831 = Set[ 11 ]
    TOKENS_FOLLOWING_NL_IN_constraint_class_quantification_1833 = Set[ 9, 11, 29, 58, 63, 73, 83, 86 ]
    TOKENS_FOLLOWING_constraint_iterator_IN_constraint_class_quantification_1840 = Set[ 11 ]
    TOKENS_FOLLOWING_NL_IN_constraint_class_quantification_1842 = Set[ 9, 11, 29, 58, 63, 73, 83, 86 ]
    TOKENS_FOLLOWING_T__86_IN_constraint_class_quantification_1850 = Set[ 1 ]
    TOKENS_FOLLOWING_T__29_IN_constraint_different_1869 = Set[ 20 ]
    TOKENS_FOLLOWING_T__20_IN_constraint_different_1871 = Set[ 9 ]
    TOKENS_FOLLOWING_path_IN_constraint_different_1873 = Set[ 21 ]
    TOKENS_FOLLOWING_T__21_IN_constraint_different_1875 = Set[ 1 ]
    TOKENS_FOLLOWING_reference_IN_constraint_statement_1894 = Set[ 1 ]
    TOKENS_FOLLOWING_T__73_IN_constraint_statement_1903 = Set[ 9 ]
    TOKENS_FOLLOWING_reference_IN_constraint_statement_1905 = Set[ 1 ]
    TOKENS_FOLLOWING_reference_IN_constraint_statement_1914 = Set[ 32, 66 ]
    TOKENS_FOLLOWING_equals_op_IN_constraint_statement_1916 = Set[ 4, 9, 10, 13, 15, 20, 35, 41 ]
    TOKENS_FOLLOWING_value_IN_constraint_statement_1918 = Set[ 1 ]
    TOKENS_FOLLOWING_reference_IN_constraint_statement_1927 = Set[ 32, 66 ]
    TOKENS_FOLLOWING_equals_op_IN_constraint_statement_1929 = Set[ 12 ]
    TOKENS_FOLLOWING_NULL_IN_constraint_statement_1931 = Set[ 1 ]
    TOKENS_FOLLOWING_reference_IN_constraint_statement_1940 = Set[ 19, 68, 69 ]
    TOKENS_FOLLOWING_not_equals_op_IN_constraint_statement_1942 = Set[ 4, 9, 10, 13, 15, 20, 35, 41 ]
    TOKENS_FOLLOWING_value_IN_constraint_statement_1944 = Set[ 1 ]
    TOKENS_FOLLOWING_reference_IN_constraint_statement_1953 = Set[ 19, 68, 69 ]
    TOKENS_FOLLOWING_not_equals_op_IN_constraint_statement_1955 = Set[ 12 ]
    TOKENS_FOLLOWING_NULL_IN_constraint_statement_1957 = Set[ 1 ]
    TOKENS_FOLLOWING_conditional_constraint_IN_constraint_statement_1966 = Set[ 1 ]
    TOKENS_FOLLOWING_reference_IN_constraint_statement_1975 = Set[ 64, 66 ]
    TOKENS_FOLLOWING_T__66_IN_constraint_statement_1977 = Set[ 64 ]
    TOKENS_FOLLOWING_T__64_IN_constraint_statement_1980 = Set[ 20, 35 ]
    TOKENS_FOLLOWING_set_value_IN_constraint_statement_1982 = Set[ 1 ]
    TOKENS_FOLLOWING_reference_IN_constraint_statement_1991 = Set[ 68, 69, 73 ]
    TOKENS_FOLLOWING_set_IN_constraint_statement_1993 = Set[ 64 ]
    TOKENS_FOLLOWING_T__64_IN_constraint_statement_2001 = Set[ 20, 35 ]
    TOKENS_FOLLOWING_set_value_IN_constraint_statement_2003 = Set[ 1 ]
    TOKENS_FOLLOWING_reference_IN_constraint_statement_2012 = Set[ 62 ]
    TOKENS_FOLLOWING_T__62_IN_constraint_statement_2014 = Set[ 4, 9, 10, 13, 15, 20, 35, 41 ]
    TOKENS_FOLLOWING_value_IN_constraint_statement_2016 = Set[ 1 ]
    TOKENS_FOLLOWING_reference_IN_constraint_statement_2025 = Set[ 30, 31, 33, 34 ]
    TOKENS_FOLLOWING_binary_comp_IN_constraint_statement_2027 = Set[ 9, 13 ]
    TOKENS_FOLLOWING_comp_value_IN_constraint_statement_2029 = Set[ 1 ]
    TOKENS_FOLLOWING_total_constraint_IN_constraint_statement_2038 = Set[ 1 ]
    TOKENS_FOLLOWING_T__83_IN_total_constraint_2049 = Set[ 9 ]
    TOKENS_FOLLOWING_total_statement_IN_total_constraint_2051 = Set[ 21 ]
    TOKENS_FOLLOWING_T__21_IN_total_constraint_2053 = Set[ 30, 31, 33, 34 ]
    TOKENS_FOLLOWING_binary_comp_IN_total_constraint_2055 = Set[ 13 ]
    TOKENS_FOLLOWING_NUMBER_IN_total_constraint_2057 = Set[ 1 ]
    TOKENS_FOLLOWING_reference_IN_total_statement_2068 = Set[ 32, 66 ]
    TOKENS_FOLLOWING_equals_op_IN_total_statement_2070 = Set[ 4, 9, 10, 13, 15, 20, 35, 41 ]
    TOKENS_FOLLOWING_value_IN_total_statement_2072 = Set[ 1 ]
    TOKENS_FOLLOWING_NUMBER_IN_comp_value_2087 = Set[ 1 ]
    TOKENS_FOLLOWING_reference_IN_comp_value_2096 = Set[ 1 ]
    TOKENS_FOLLOWING_T__63_IN_conditional_constraint_2115 = Set[ 9, 63, 73, 83, 85 ]
    TOKENS_FOLLOWING_conditional_constraint_if_part_IN_conditional_constraint_2123 = Set[ 82 ]
    TOKENS_FOLLOWING_conditional_constraint_then_part_IN_conditional_constraint_2127 = Set[ 1 ]
    TOKENS_FOLLOWING_constraint_statement_IN_conditional_constraint_if_part_2142 = Set[ 1, 11 ]
    TOKENS_FOLLOWING_NL_IN_conditional_constraint_if_part_2144 = Set[ 1, 11 ]
    TOKENS_FOLLOWING_T__85_IN_conditional_constraint_if_part_2154 = Set[ 11 ]
    TOKENS_FOLLOWING_NL_IN_conditional_constraint_if_part_2162 = Set[ 9, 11, 54, 57, 58, 59, 63, 73, 83, 86 ]
    TOKENS_FOLLOWING_constraint_body_IN_conditional_constraint_if_part_2165 = Set[ 86 ]
    TOKENS_FOLLOWING_T__86_IN_conditional_constraint_if_part_2169 = Set[ 1, 11 ]
    TOKENS_FOLLOWING_NL_IN_conditional_constraint_if_part_2171 = Set[ 1, 11 ]
    TOKENS_FOLLOWING_T__82_IN_conditional_constraint_then_part_2187 = Set[ 9, 63, 73, 83 ]
    TOKENS_FOLLOWING_constraint_statement_IN_conditional_constraint_then_part_2189 = Set[ 1 ]
    TOKENS_FOLLOWING_T__82_IN_conditional_constraint_then_part_2198 = Set[ 85 ]
    TOKENS_FOLLOWING_T__85_IN_conditional_constraint_then_part_2206 = Set[ 11 ]
    TOKENS_FOLLOWING_NL_IN_conditional_constraint_then_part_2208 = Set[ 9, 11, 54, 57, 58, 59, 63, 73, 83, 86 ]
    TOKENS_FOLLOWING_constraint_body_IN_conditional_constraint_then_part_2211 = Set[ 86 ]
    TOKENS_FOLLOWING_T__86_IN_conditional_constraint_then_part_2213 = Set[ 1 ]
    TOKENS_FOLLOWING_mutation_IN_effect_body_2235 = Set[ 11 ]
    TOKENS_FOLLOWING_mutation_iterator_IN_effect_body_2248 = Set[ 11 ]
    TOKENS_FOLLOWING_NL_IN_effect_body_2257 = Set[ 1, 9, 11, 50, 58 ]
    TOKENS_FOLLOWING_T__58_IN_mutation_iterator_2272 = Set[ 9 ]
    TOKENS_FOLLOWING_path_IN_mutation_iterator_2274 = Set[ 43 ]
    TOKENS_FOLLOWING_T__43_IN_mutation_iterator_2276 = Set[ 9 ]
    TOKENS_FOLLOWING_ID_IN_mutation_iterator_2278 = Set[ 11, 85 ]
    TOKENS_FOLLOWING_NL_IN_mutation_iterator_2280 = Set[ 11, 85 ]
    TOKENS_FOLLOWING_T__85_IN_mutation_iterator_2283 = Set[ 11 ]
    TOKENS_FOLLOWING_NL_IN_mutation_iterator_2285 = Set[ 9, 11, 50, 86 ]
    TOKENS_FOLLOWING_mutation_IN_mutation_iterator_2295 = Set[ 11 ]
    TOKENS_FOLLOWING_NL_IN_mutation_iterator_2303 = Set[ 9, 11, 50, 86 ]
    TOKENS_FOLLOWING_T__86_IN_mutation_iterator_2310 = Set[ 1 ]
    TOKENS_FOLLOWING_reference_IN_mutation_2329 = Set[ 32, 66 ]
    TOKENS_FOLLOWING_equals_op_IN_mutation_2331 = Set[ 4, 9, 10, 13, 15, 20, 35, 41 ]
    TOKENS_FOLLOWING_value_IN_mutation_2333 = Set[ 1 ]
    TOKENS_FOLLOWING_reference_IN_mutation_2342 = Set[ 32, 66 ]
    TOKENS_FOLLOWING_equals_op_IN_mutation_2344 = Set[ 12 ]
    TOKENS_FOLLOWING_NULL_IN_mutation_2346 = Set[ 1 ]
    TOKENS_FOLLOWING_reference_IN_mutation_2355 = Set[ 22, 23, 25, 27 ]
    TOKENS_FOLLOWING_binary_op_IN_mutation_2357 = Set[ 13 ]
    TOKENS_FOLLOWING_NUMBER_IN_mutation_2359 = Set[ 1 ]
    TOKENS_FOLLOWING_reference_IN_mutation_2368 = Set[ 66 ]
    TOKENS_FOLLOWING_T__66_IN_mutation_2370 = Set[ 72 ]
    TOKENS_FOLLOWING_T__72_IN_mutation_2372 = Set[ 9 ]
    TOKENS_FOLLOWING_path_IN_mutation_2374 = Set[ 1, 85 ]
    TOKENS_FOLLOWING_object_body_IN_mutation_2382 = Set[ 1 ]
    TOKENS_FOLLOWING_T__50_IN_mutation_2392 = Set[ 9 ]
    TOKENS_FOLLOWING_path_IN_mutation_2394 = Set[ 1 ]
    TOKENS_FOLLOWING_reference_IN_mutation_2403 = Set[ 38 ]
    TOKENS_FOLLOWING_T__38_IN_mutation_2405 = Set[ 4, 9, 10, 13, 15, 20, 35, 41 ]
    TOKENS_FOLLOWING_value_IN_mutation_2407 = Set[ 21 ]
    TOKENS_FOLLOWING_T__21_IN_mutation_2409 = Set[ 1 ]
    TOKENS_FOLLOWING_reference_IN_mutation_2418 = Set[ 76 ]
    TOKENS_FOLLOWING_T__76_IN_mutation_2420 = Set[ 4, 9, 10, 13, 15, 20, 35, 41 ]
    TOKENS_FOLLOWING_value_IN_mutation_2422 = Set[ 21 ]
    TOKENS_FOLLOWING_T__21_IN_mutation_2424 = Set[ 1 ]
    TOKENS_FOLLOWING_set_IN_set_value_2443 = Set[ 4, 9, 10, 13, 15, 20, 21, 35, 36, 41 ]
    TOKENS_FOLLOWING_set_item_IN_set_value_2456 = Set[ 21, 24, 36 ]
    TOKENS_FOLLOWING_T__24_IN_set_value_2459 = Set[ 4, 9, 10, 11, 13, 15, 20, 35, 41 ]
    TOKENS_FOLLOWING_NL_IN_set_value_2461 = Set[ 4, 9, 10, 11, 13, 15, 20, 35, 41 ]
    TOKENS_FOLLOWING_set_item_IN_set_value_2464 = Set[ 21, 24, 36 ]
    TOKENS_FOLLOWING_set_IN_set_value_2476 = Set[ 1 ]
    TOKENS_FOLLOWING_value_IN_set_item_2491 = Set[ 1 ]
    TOKENS_FOLLOWING_primitive_value_IN_value_2510 = Set[ 1 ]
    TOKENS_FOLLOWING_reference_IN_value_2519 = Set[ 1 ]
    TOKENS_FOLLOWING_set_value_IN_value_2528 = Set[ 1 ]
    TOKENS_FOLLOWING_T__41_IN_value_2537 = Set[ 1 ]
    TOKENS_FOLLOWING_BOOLEAN_IN_primitive_value_2556 = Set[ 1 ]
    TOKENS_FOLLOWING_NUMBER_IN_primitive_value_2565 = Set[ 1 ]
    TOKENS_FOLLOWING_STRING_IN_primitive_value_2574 = Set[ 1 ]
    TOKENS_FOLLOWING_MULTILINE_STRING_IN_primitive_value_2583 = Set[ 1 ]
    TOKENS_FOLLOWING_ID_IN_path_2598 = Set[ 1, 26 ]
    TOKENS_FOLLOWING_T__26_IN_path_2600 = Set[ 9 ]
    TOKENS_FOLLOWING_ID_IN_path_2601 = Set[ 1, 26 ]
    TOKENS_FOLLOWING_id_ref_IN_path_with_index_2614 = Set[ 1, 26 ]
    TOKENS_FOLLOWING_T__26_IN_path_with_index_2616 = Set[ 9 ]
    TOKENS_FOLLOWING_id_ref_IN_path_with_index_2617 = Set[ 1, 26 ]
    TOKENS_FOLLOWING_ID_IN_id_ref_2630 = Set[ 1, 35 ]
    TOKENS_FOLLOWING_T__35_IN_id_ref_2632 = Set[ 13 ]
    TOKENS_FOLLOWING_NUMBER_IN_id_ref_2634 = Set[ 36 ]
    TOKENS_FOLLOWING_T__36_IN_id_ref_2636 = Set[ 1 ]
    TOKENS_FOLLOWING_path_with_index_IN_reference_2653 = Set[ 1 ]
    TOKENS_FOLLOWING_T__70_IN_reference_type_2672 = Set[ 9 ]
    TOKENS_FOLLOWING_path_IN_reference_type_2674 = Set[ 1 ]
    TOKENS_FOLLOWING_T__71_IN_set_type_2693 = Set[ 9 ]
    TOKENS_FOLLOWING_path_IN_set_type_2695 = Set[ 1 ]
    TOKENS_FOLLOWING_T__53_IN_probability_op_2710 = Set[ 1 ]

  end # class Parser < ANTLR3::Parser

  at_exit { Parser.main( ARGV ) } if __FILE__ == $0

end
