% David Ramirez A01206423

ch_id(hvhu, ucvax).
ch_id(ppy, ucvax).
ch_id(ynme, ucsj_vy).
ch_id(my_id, my_channel).
id(hvhu).
id(ppy).
id(ynme).
id(my_id).
keywords(hvhu, [weezer, island, in, the, sun]).
keywords(ppy, [hbo, louie, little, special, very, george]).
keywords(ynme, [video]).
keywords(my_id, [video, weezer, tame, special]).
length_sec(hvhu,  210).
length_sec(ppy,  320).
length_sec(ynme, 217).
length_sec(my_id, 500).
name(hvhu, weezer_island_in_the_sun).
name(ppy, louis_ck).
name(ynme, tame_impala_the_less_i_know_the_better).
name(my_id, my_video_dot_mp3).

is_long_video(Id):-
  length_sec(Id, Time),
  Time > 319.

is_interesting_for_tags(Id, Key_list):-
  keywords(Id, Vid_word),
  h_func_key(Key_list, Vid_word).


h_func_key([H|T], List):-
  member(H, List);
  h_func_key(T, List).

by_channel(Ch_id, Res):-
  ch_id(Res, Ch_id).

name_of_id(Id, Res):-
  name(Id, Res).

has_keyword(Keyword, Res):-
  id(Id),
  keywords(Id, Vid_word),
  name_helper(Keyword, Vid_word),
  name(Id, Res).

name_helper(Keyword, Vid_word):-
  member(Keyword, Vid_word).

common_vid_tag(Id1, Id2, Res):-
  keywords(Id1, Lis1),
  keywords(Id2, Lis2),
  common_tags(Lis1, Lis2, Res).

common_tags([], _, []).

common_tags([H|T], List, [H|Res]):-
  member(H, List),
  common_tags(T, List, Res).

common_tags([_|T], List, Res):-
  common_tags(T, List, Res).
