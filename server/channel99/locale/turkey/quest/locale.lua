-- #################################################################
-- ##                                                             ##
-- ##                        LOCALE.LUA                           ##
-- ##                                                             ##
-- ## Background:                                                 ##
-- ##   This file provides Metin2 with one big array!             ##
-- ##   This array contains some configurations values and a lot  ##
-- ##   of strings to translate. Also every quest-file contains   ##
-- ##   string to translate.                                      ##
-- ##                                                             ##
-- ## Gameforge-Way-To-Do:                                        ##
-- ##   We extract everything we need to translate from this file ##
-- ##   into one big "Key = Value"-file. Simple key-value-files   ##
-- ##   can be managed by our localisation-tool.                  ##
-- ##   Also we extract every string out of every .quest-file and ##
-- ##   generate a lots of new keys. These keys are used in the   ##
-- ##   .quest-files.                                             ##
-- ##                                                             ##
-- ##   !! The key-value-file is called 'translate.lua'           ##
-- ##                                                             ##
-- ## The Advantage:                                              ##
-- ##   1) We can easily translate everything with our tool       ##
-- ##   2) We cant create syntax-errors in this file              ##
-- ##   3) We cant create syntax-errors in the quest-files        ##
-- ##   4) We can compare the quest-files between two languages   ##
-- ##      to find differences if something is broken in only     ##
-- ##      country.                                               ##
-- ##                                                             ##
-- #################################################################

locale = {}
locale.man_postfix = gameforge.locale.man_postfix
locale.woman_postfix = gameforge.locale.woman_postfix
locale.confirm = gameforge.locale.confirm
locale.reward = gameforge.locale.reward
locale.exp = gameforge.locale.exp
locale.count_prefix = gameforge.locale.count_prefix
locale.count_postfix = gameforge.locale.count_postfix
locale.level = gameforge.locale.level
locale.quest_word = gameforge.locale.quest_word
locale.complete = gameforge.locale.complete
locale.start = gameforge.locale.start
locale.chat = gameforge.locale.chat
locale.eliminate_on_begin = gameforge.locale.eliminate_on_begin
locale.eliminate_on_end = gameforge.locale.eliminate_on_end
locale.yes = gameforge.locale.yes
locale.no = gameforge.locale.no
locale.cancel = gameforge.locale.cancel
locale.gold = gameforge.locale.gold
locale.need_item_prefix = gameforge.locale.need_item_prefix
locale.need_item_postfix = gameforge.locale.need_item_postfix
locale.map_name = {
	[61] = gameforge.locale.map_name_1,
	[62] = gameforge.locale.map_name_2,
	[63] = gameforge.locale.map_name_3,
	[64] = gameforge.locale.map_name_4,
}
locale.empire_names = {
	[0] = gameforge.locale.empire_names_1,
	[1] = gameforge.locale.empire_names_2,
	[2] = gameforge.locale.empire_names_3,
	[3] = gameforge.locale.empire_names_4,
}
locale.item_drop_pct = gameforge.locale.item_drop_pct
locale.gold_drop_pct = gameforge.locale.gold_drop_pct
locale.tengold_drop_pct = gameforge.locale.tengold_drop_pct
locale.exp_pct = gameforge.locale.exp_pct
locale.show_guild_ranking_top = gameforge.locale.show_guild_ranking_top
locale.show_guild_ranking_around = gameforge.locale.show_guild_ranking_around
locale.show_guild_cur_score = gameforge.locale.show_guild_cur_score
locale.guild_around_rank_msg = gameforge.locale.guild_around_rank_msg
locale.guild_top_rank_msg = gameforge.locale.guild_top_rank_msg
locale.guild_rank_head = gameforge.locale.guild_rank_head
locale.guild_your_rank1 = gameforge.locale.guild_your_rank1
locale.guild_your_rank2 = gameforge.locale.guild_your_rank2
locale.guild_your_rank3 = gameforge.locale.guild_your_rank3
locale.deviltower_man_chat = gameforge.locale.deviltower_man_chat
locale.deviltower_man_say = gameforge.locale.deviltower_man_say
locale.deviltower_man_say_you_cant = gameforge.locale.deviltower_man_say_you_cant 
locale.deviltower_enter = gameforge.locale.deviltower_enter
locale.deviltower_no_enter = gameforge.locale.deviltower_no_enter
locale.forked_man_chat = gameforge.locale.forked_man_chat
locale.forked_man_say = gameforge.locale.forked_man_say
locale.forked_man_say_cant = gameforge.locale.forked_man_say_cant
locale.forked_enter = gameforge.locale.forked_enter
locale.forked_no_enter = gameforge.locale.forked_no_enter
locale.forked_open_gate = gameforge.locale.forked_open_gate
locale.forked_kill_boss = gameforge.locale.forked_kill_boss
locale.forked_condition = gameforge.locale.forked_condition
locale.forked_condition2 = gameforge.locale.forked_condition2
locale.forked_rule = gameforge.locale.forked_rule
locale.forked_rule_sungzi = gameforge.locale.forked_rule_sungzi
locale.login_notice = gameforge.locale.login_notice
locale.NOTICE_COLOR = color256(255, 230, 186)
locale.NORMAL_COLOR = color256(196, 196, 196)
locale.QUEST_TEMP_REWARD = locale.NOTICE_COLOR .. gameforge.locale.quest_temp_reward_1 .. locale.NORMAL_COLOR .. gameforge.locale.quest_temp_reward_2 

locale.yeonnahwan = {}
locale.yeonnahwan.start_level_begin = 99
locale.yeonnahwan.start_level_end = 99
locale.yeonnahwan.start_probability = 1
locale.yeonnahwan.end_level = 99
locale.yeonnahwan.kill_count = 1
locale.yeonnahwan.event_item = gameforge.locale.yeonnahwan.event_item
locale.yeonnahwan.find_yeonnahwan_label = gameforge.locale.yeonnahwan.find_yeonnahwan_label
locale.yeonnahwan.find_yeonnahwan_text = locale.NOTICE_COLOR .. gameforge.locale.yeonnahwan.find_yeonnahwan_text_1 .. locale.NORMAL_COLOR .. gameforge.locale.yeonnahwan.find_yeonnahwan_text_2
locale.yeonnahwan.find_eulduji_label = gameforge.locale.yeonnahwan.find_eulduji_label
locale.yeonnahwan.find_eulduji_text = locale.NOTICE_COLOR .. gameforge.locale.yeonnahwan.find_eulduji_text_1 .. locale.NORMAL_COLOR .. gameforge.locale.yeonnahwan.find_eulduji_text_2
locale.yeonnahwan.report_label = gameforge.locale.yeonnahwan.report_label
locale.yeonnahwan.report_text = gameforge.locale.yeonnahwan.report_text
locale.yeonnahwan.kill_unggwi_label = gameforge.locale.yeonnahwan.kill_unggwi_label
locale.yeonnahwan.kill_unggwi_text = locale.NOTICE_COLOR .. gameforge.locale.yeonnahwan.kill_unggwi_text_1 .. locale.NORMAL_COLOR .. gameforge.locale.yeonnahwan.kill_unggwi_text_2

locale.huanso = {}
locale.huanso.start_level_begin = 32
locale.huanso.start_level_end = 35
locale.huanso.start_probability = 3
locale.huanso.end_level = 38
locale.huanso.kill_count = 3
locale.huanso.event_item = 30102
locale.huanso.order_label = gameforge.locale.huanso.order_label
locale.huanso.order_text = locale.NOTICE_COLOR .. gameforge.locale.huanso.order_text_1 .. locale.NORMAL_COLOR .. gameforge.locale.huanso.order_text_2
locale.huanso.too_late = gameforge.locale.huanso.too_late
locale.huanso.find_label = gameforge.locale.huanso.find_label
locale.huanso.find_text = locale.NOTICE_COLOR .. gameforge.locale.huanso.find_text_1 .. locale.NORMAL_COLOR .. gameforge.locale.huanso.find_text_2
locale.huanso.kill_label = gameforge.locale.huanso.kill_label
locale.huanso.kill_text = locale.NOTICE_COLOR .. gameforge.locale.huanso.kill_text_1 .. locale.NORMAL_COLOR .. gameforge.locale.huanso.kill_text_2
locale.huanso.make_label = gameforge.locale.huanso.make_label
locale.huanso.make_text = locale.NOTICE_COLOR .. gameforge.locale.huanso.make_text_1 .. locale.NORMAL_COLOR .. gameforge.locale.huanso.make_text_2
locale.huanso.deliver_label = gameforge.locale.huanso.deliver_label
locale.huanso.deliver_text = locale.NOTICE_COLOR .. gameforge.locale.huanso.deliver_text_1 .. locale.NORMAL_COLOR .. gameforge.locale.huanso.deliver_text_2
locale.huanso.success_label = gameforge.locale.huanso.success_label
locale.huanso.success_text = locale.NOTICE_COLOR .. gameforge.locale.huanso.success_text_1 .. locale.NORMAL_COLOR .. gameforge.locale.huanso.success_text_2
locale.huanso.failure_label = gameforge.locale.huanso.failure_label
locale.huanso.failure_text = locale.NOTICE_COLOR .. gameforge.locale.huanso.failure_text_1 .. locale.NORMAL_COLOR .. gameforge.locale.huanso.failure_text_2

locale.yuhwan = {}
locale.yuhwan.start_level_begin = 40
locale.yuhwan.start_level_end = 43
locale.yuhwan.start_probability = 3
locale.yuhwan.end_level = 45
locale.yuhwan.kill_count = 3
locale.yuhwan.event_item = 30102
locale.yuhwan.find_label = gameforge.locale.yuhwan.find_label
locale.yuhwan.find_text = locale.NOTICE_COLOR .. gameforge.locale.yuhwan.find_text_1 .. locale.NORMAL_COLOR .. gameforge.locale.yuhwan.find_text_2
locale.yuhwan.too_late = gameforge.locale.yuhwan.too_late
locale.yuhwan.kill_label = gameforge.locale.yuhwan.kill_label
locale.yuhwan.kill_text = locale.NOTICE_COLOR .. gameforge.locale.yuhwan.kill_text_1 .. locale.NORMAL_COLOR .. gameforge.locale.yuhwan.kill_text_2
locale.yuhwan.success_info_label = gameforge.locale.yuhwan.success_info_label
locale.yuhwan.success_info_text = locale.NOTICE_COLOR .. gameforge.locale.yuhwan.success_info_text_1 .. locale.NORMAL_COLOR .. gameforge.locale.yuhwan.success_info_text_2
locale.yuhwan.failure_info_label = gameforge.locale.yuhwan.failure_info_label
locale.yuhwan.failure_info_text = locale.NOTICE_COLOR .. gameforge.locale.yuhwan.failure_info_text_1 .. locale.NORMAL_COLOR .. gameforge.locale.yuhwan.failure_info_text_2

locale.deokbae = {}
locale.deokbae.start_level_begin = 80
locale.deokbae.start_level_end = 80
locale.deokbae.start_probability = 3
locale.deokbae.end_level = 40
locale.deokbae.kill_count = 3
locale.deokbae.event_item = 30102
locale.deokbae.find_deokbae_label = gameforge.locale.deokbae.find_deokbae_label
locale.deokbae.find_deokbae_text = locale.NOTICE_COLOR .. gameforge.locale.deokbae.find_deokbae_text_1 .. locale.NORMAL_COLOR .. gameforge.locale.deokbae.find_deokbae_text_2
locale.deokbae.too_late = gameforge.locale.deokbae.too_late
locale.deokbae.kill_label = gameforge.locale.deokbae.kill_label
locale.deokbae.kill_text = locale.NOTICE_COLOR .. gameforge.locale.deokbae.kill_text_1 .. locale.NORMAL_COLOR .. gameforge.locale.deokbae.kill_text_2
locale.deokbae.success_info_label = gameforge.locale.deokbae.success_info_label
locale.deokbae.success_info_text = locale.NOTICE_COLOR .. gameforge.locale.deokbae.success_info_text_1 .. locale.NORMAL_COLOR .. gameforge.locale.deokbae.success_info_text_2
locale.deokbae.failure_info_label = gameforge.locale.deokbae.failure_info_label
locale.deokbae.failure_info_text = locale.NOTICE_COLOR .. gameforge.locale.deokbae.failure_info_text_1 .. locale.NORMAL_COLOR .. gameforge.locale.deokbae.failure_info_text_2

locale.bookworm = {}
locale.bookworm.start_level_begin = 28
locale.bookworm.start_level_end = 31
locale.bookworm.start_probability = 3
locale.bookworm.end_level = 34
locale.bookworm.kill_count = 3
locale.bookworm.talk = gameforge.locale.bookworm.talk
locale.bookworm.aranyeo_talk = gameforge.locale.bookworm.aranyeo_talk
locale.bookworm.etc_shop_talk_about_bookworm = gameforge.locale.bookworm.etc_shop_talk_about_bookworm
locale.bookworm.talk_about_milgyo_book = gameforge.locale.bookworm.talk_about_milgyo_book
locale.bookworm.do_you_find_the_book = gameforge.locale.bookworm.do_you_find_the_book
locale.bookworm.do_you_mean_this_book = gameforge.locale.bookworm.do_you_mean_this_book
locale.bookworm.START_say = gameforge.locale.bookworm.start_say
locale.bookworm.START_say2 = gameforge.locale.bookworm.start_say2
locale.bookworm.aranyeo_START_say = gameforge.locale.bookworm.aranyeo_start_say
locale.bookworm.aranyeo_START_say2 = gameforge.locale.bookworm.aranyeo_start_say2
locale.bookworm.etc_shop_START_say = gameforge.locale.bookworm.etc_shop_start_say
locale.bookworm.etc_shop_START_say2 = gameforge.locale.bookworm.etc_shop_start_say2
locale.bookworm.START_find_bookworm_label = gameforge.locale.bookworm.start_find_bookworm_label
locale.bookworm.START_find_bookworm_text = locale.NOTICE_COLOR .. gameforge.locale.bookworm.start_find_bookworm_text_1 .. locale.NORMAL_COLOR .. gameforge.locale.bookworm.start_find_bookworm_text_2
locale.bookworm.ORDER_say1 = gameforge.locale.bookworm.order_say1
locale.bookworm.ORDER_say2 = gameforge.locale.bookworm.order_say2
locale.bookworm.ORDER_accept = gameforge.locale.bookworm.order_accept
locale.bookworm.ORDER_refuse = gameforge.locale.bookworm.order_refuse
locale.bookworm.ORDER_accept_answer = gameforge.locale.bookworm.order_accept_answer
locale.bookworm.ORDER_refuse_answer = gameforge.locale.bookworm.order_refuse_answer
locale.bookworm.ORDER_find_book_label = gameforge.locale.bookworm.order_find_book_label
locale.bookworm.ORDER_find_book_text = locale.NOTICE_COLOR .. gameforge.locale.bookworm.order_find_book_text_1 .. locale.NORMAL_COLOR .. gameforge.locale.bookworm.order_find_book_text_2
locale.bookworm.ORDER_too_late = gameforge.locale.bookworm.order_too_late
locale.bookworm.ACCEPT_success_say = locale.NOTICE_COLOR .. gameforge.locale.bookworm.accept_success_say_1 .. locale.NORMAL_COLOR .. gameforge.locale.bookworm.accept_success_say_2
locale.bookworm.ACCEPT_failure_say = locale.NOTICE_COLOR .. gameforge.locale.bookworm.accept_failure_say_1 .. locale.NORMAL_COLOR .. gameforge.locale.bookworm.accept_failure_say_2
locale.bookworm.ACCEPT_ask = gameforge.locale.bookworm.accept_ask
locale.bookworm.ACCEPT_success_info_label = gameforge.locale.bookworm.accept_success_info_label
locale.bookworm.ACCEPT_success_info_text = locale.NOTICE_COLOR .. gameforge.locale.bookworm.accept_success_info_text_1 .. locale.NORMAL_COLOR .. gameforge.locale.bookworm.accept_success_info_text_2
locale.bookworm.ACCEPT_failure_info_label = gameforge.locale.bookworm.accept_failure_info_label
locale.bookworm.ACCEPT_failure_info_text = locale.NOTICE_COLOR .. gameforge.locale.bookworm.accept_failure_info_text_1 .. locale.NORMAL_COLOR .. gameforge.locale.bookworm.accept_failure_info_text_2
locale.bookworm.SUCCESS_thanks = gameforge.locale.bookworm.success_thanks
locale.bookworm.COMPLETE_say = gameforge.locale.bookworm.complete_say
locale.bookworm.aranyeo_COMPLETE_say = gameforge.locale.bookworm.aranyeo_complete_say
locale.bookworm.aranyeo_COMPLETE_say2 = gameforge.locale.bookworm.aranyeo_complete_say2

locale.old_pirate = {}
locale.old_pirate.start_level_begin = 48
locale.old_pirate.start_level_end = 51
locale.old_pirate.start_probability = 3
locale.old_pirate.end_level = 54
locale.old_pirate.kill_count = 3
locale.old_pirate.talk = gameforge.locale.old_pirate.talk
locale.old_pirate.baekgo_talk = gameforge.locale.old_pirate.baekgo_talk
locale.old_pirate.etc_shop_talk_about_old_pirate = gameforge.locale.old_pirate.etc_shop_talk_about_old_pirate
locale.old_pirate.talk_about_medicine = gameforge.locale.old_pirate.talk_about_medicine
locale.old_pirate.do_you_get_the_medicine = gameforge.locale.old_pirate.do_you_get_the_medicine
locale.old_pirate.do_you_mean_this_medicine = gameforge.locale.old_pirate.do_you_mean_this_medicine
locale.old_pirate.baekgo_talk_about_old_pirate = gameforge.locale.old_pirate.baekgo_talk_about_old_pirate
locale.old_pirate.baekgo_do_you_get_the_virus = gameforge.locale.old_pirate.baekgo_do_you_get_the_virus
locale.old_pirate.baekgo_iv_got_the_virus = gameforge.locale.old_pirate.baekgo_iv_got_the_virus
locale.old_pirate.START_say = gameforge.locale.old_pirate.start_say
locale.old_pirate.etc_shop_START_say = gameforge.locale.old_pirate.etc_shop_start_say
locale.old_pirate.etc_shop_START_say2 = gameforge.locale.old_pirate.etc_shop_start_say2
locale.old_pirate.START_find_old_pirate_label = gameforge.locale.old_pirate.start_find_old_pirate_label
locale.old_pirate.START_find_old_pirate_text = locale.NOTICE_COLOR .. gameforge.locale.old_pirate.start_find_old_pirate_text_1 .. locale.NORMAL_COLOR .. gameforge.locale.old_pirate.start_find_old_pirate_text_2
locale.old_pirate.ORDER_say1 = gameforge.locale.old_pirate.order_say1
locale.old_pirate.ORDER_say2 = gameforge.locale.old_pirate.order_say2
locale.old_pirate.ORDER_accept = gameforge.locale.old_pirate.order_accept
locale.old_pirate.ORDER_refuse = gameforge.locale.old_pirate.order_refuse
locale.old_pirate.ORDER_accept_answer = gameforge.locale.old_pirate.order_accept_answer
locale.old_pirate.ORDER_refuse_answer = gameforge.locale.old_pirate.order_refuse_answer
locale.old_pirate.ORDER_find_medicine_label = gameforge.locale.old_pirate.order_find_medicine_label
locale.old_pirate.ORDER_find_medicine_text = locale.NOTICE_COLOR .. gameforge.locale.old_pirate.order_find_medicine_text_1 .. locale.NORMAL_COLOR .. gameforge.locale.old_pirate.order_find_medicine_text_2
locale.old_pirate.ORDER_too_late = gameforge.locale.old_pirate.order_too_late
locale.old_pirate.ACCEPT_success_say = locale.NOTICE_COLOR .. gameforge.locale.old_pirate.accept_success_say_1 .. locale.NORMAL_COLOR .. gameforge.locale.old_pirate.accept_success_say_2
locale.old_pirate.ACCEPT_failure_say = locale.NOTICE_COLOR .. gameforge.locale.old_pirate.accept_failure_say_1 .. locale.NORMAL_COLOR .. gameforge.locale.old_pirate.accept_failure_say_2
locale.old_pirate.ACCEPT_ask = gameforge.locale.old_pirate.accept_ask
locale.old_pirate.ACCEPT_success_info_label = gameforge.locale.old_pirate.accept_success_info_label
locale.old_pirate.ACCEPT_success_info_text = locale.NOTICE_COLOR .. gameforge.locale.old_pirate.accept_success_info_text_1 .. locale.NORMAL_COLOR .. gameforge.locale.old_pirate.accept_success_info_text_2
locale.old_pirate.ACCEPT_failure_info_label = gameforge.locale.old_pirate.accept_failure_info_label
locale.old_pirate.ACCEPT_failure_info_text = locale.NOTICE_COLOR .. gameforge.locale.old_pirate.accept_failure_info_text_1 .. locale.NORMAL_COLOR .. gameforge.locale.old_pirate.accept_failure_info_text_2
locale.old_pirate.BAEKGO_START_say = gameforge.locale.old_pirate.baekgo_start_say
locale.old_pirate.BAEKGO_START_say2 = gameforge.locale.old_pirate.baekgo_start_say2
locale.old_pirate.BAEKGO_START_say3 = gameforge.locale.old_pirate.baekgo_start_say3
locale.old_pirate.BAEKGO_ORDER_find_virus_label = gameforge.locale.old_pirate.baekgo_order_find_virus_label
locale.old_pirate.BAEKGO_ORDER_find_virus_text = locale.NOTICE_COLOR .. gameforge.locale.old_pirate.baekgo_order_find_virus_text_1 .. locale.NORMAL_COLOR .. gameforge.locale.old_pirate.baekgo_order_find_virus_text_2
locale.old_pirate.BAEKGO_ORDER_too_late = gameforge.locale.old_pirate.baekgo_order_too_late
locale.old_pirate.BAEKGO_ACCEPT_success_say = locale.NOTICE_COLOR .. gameforge.locale.old_pirate.baekgo_accept_success_say_1 .. locale.NORMAL_COLOR .. gameforge.locale.old_pirate.baekgo_accept_success_say_2
locale.old_pirate.BAEKGO_ACCEPT_failure_say = locale.NOTICE_COLOR .. gameforge.locale.old_pirate.baekgo_accept_failure_say_1 .. locale.NORMAL_COLOR .. gameforge.locale.old_pirate.baekgo_accept_failure_say_2
locale.old_pirate.BAEKGO_ACCEPT_ask = gameforge.locale.old_pirate.baekgo_accept_ask
locale.old_pirate.BAEKGO_ACCEPT_success_info_label = gameforge.locale.old_pirate.baekgo_accept_success_info_label
locale.old_pirate.BAEKGO_ACCEPT_success_info_text = locale.NOTICE_COLOR .. gameforge.locale.old_pirate.baekgo_accept_success_info_text_1 .. locale.NORMAL_COLOR .. gameforge.locale.old_pirate.baekgo_accept_success_info_text_2
locale.old_pirate.BAEKGO_ACCEPT_failure_info_label = gameforge.locale.old_pirate.baekgo_accept_failure_info_label
locale.old_pirate.BAEKGO_ACCEPT_failure_info_text = locale.NOTICE_COLOR .. gameforge.locale.old_pirate.baekgo_accept_failure_info_text_1 .. locale.NORMAL_COLOR .. gameforge.locale.old_pirate.baekgo_accept_failure_info_text_2
locale.old_pirate.BAEKGO_SUCCESS_say = gameforge.locale.old_pirate.baekgo_success_say
locale.old_pirate.SUCCESS_thanks = gameforge.locale.old_pirate.success_thanks
locale.old_pirate.COMPLETE_say = gameforge.locale.old_pirate.complete_say

locale.stamina_food = {}
locale.stamina_food.butcher = {}
locale.stamina_food.food_manager = {}
locale.stamina_food.start_probability = 3
locale.stamina_food.start_level_begin = 90
locale.stamina_food.start_level_end = 90
locale.stamina_food.end_level = 59
locale.stamina_food.kill_count = 3
locale.stamina_food.butcher.talk = gameforge.locale.stamina_food.butcher.talk
locale.stamina_food.food_manager.talk = gameforge.locale.stamina_food.food_manager.talk
locale.stamina_food.food_manager.talk_about_greeenfrog_soup = gameforge.locale.stamina_food.food_manager.talk_about_greeenfrog_soup
locale.stamina_food.i_dont_have_the_greeenfrog_meat_yet = gameforge.locale.stamina_food.i_dont_have_the_greeenfrog_meat_yet
locale.stamina_food.i_have_the_greenfrog_meat = gameforge.locale.stamina_food.i_have_the_greenfrog_meat
locale.stamina_food.butcher.START_say = gameforge.locale.stamina_food.butcher.start_say
locale.stamina_food.butcher.START_say2 = gameforge.locale.stamina_food.butcher.start_say2
locale.stamina_food.food_manager.ORDER_say = gameforge.locale.stamina_food.food_manager.order_say
locale.stamina_food.food_manager.ORDER_say2 = gameforge.locale.stamina_food.food_manager.order_say2
locale.stamina_food.ORDER_accept = gameforge.locale.stamina_food.order_accept
locale.stamina_food.ORDER_refuse = gameforge.locale.stamina_food.order_refuse
locale.stamina_food.ORDER_accept_answer = gameforge.locale.stamina_food.order_accept_answer
locale.stamina_food.ORDER_refuse_answer = gameforge.locale.stamina_food.order_refuse_answer
locale.stamina_food.ORDER_get_greenfrog_general_meat_label = gameforge.locale.stamina_food.order_get_greenfrog_general_meat_label
locale.stamina_food.ORDER_get_greenfrog_general_meat_text = locale.NOTICE_COLOR .. gameforge.locale.stamina_food.order_get_greenfrog_general_meat_text
locale.stamina_food.ORDER_too_late = gameforge.locale.stamina_food.order_too_late
locale.stamina_food.ACCEPT_success_say = locale.NOTICE_COLOR .. gameforge.locale.stamina_food.accept_success_say_1 .. locale.NORMAL_COLOR .. gameforge.locale.stamina_food.accept_success_say_2
locale.stamina_food.ACCEPT_failure_say = locale.NOTICE_COLOR .. gameforge.locale.stamina_food.accept_failure_say_1 .. locale.NORMAL_COLOR .. gameforge.locale.stamina_food.accept_failure_say_2
locale.stamina_food.ACCEPT_ask = gameforge.locale.stamina_food.accept_ask
locale.stamina_food.ACCEPT_success_info_label = gameforge.locale.stamina_food.accept_success_info_label
locale.stamina_food.ACCEPT_success_info_text = locale.NOTICE_COLOR .. gameforge.locale.stamina_food.accept_success_info_text_1 .. locale.NORMAL_COLOR .. gameforge.locale.stamina_food.accept_success_info_text_2
locale.stamina_food.BAEKGO_ACCEPT_failure_info_label = gameforge.locale.stamina_food.baekgo_accept_failure_info_label
locale.stamina_food.BAEKGO_ACCEPT_failure_info_text = locale.NOTICE_COLOR .. gameforge.locale.stamina_food.baekgo_accept_failure_info_text_1 .. locale.NORMAL_COLOR .. gameforge.locale.stamina_food.baekgo_accept_failure_info_text_2
locale.stamina_food.SUCCESS_say = gameforge.locale.stamina_food.success_say
locale.stamina_food.COMPLETE_say = gameforge.locale.stamina_food.complete_say

locale.skeleton_gem = {}
locale.skeleton_gem.start_probability = 3
locale.skeleton_gem.start_level_begin = 55
locale.skeleton_gem.start_level_end = 57
locale.skeleton_gem.end_level = 60
locale.skeleton_gem.kill_count = 3
locale.skeleton_gem.talk_about_skeleton_gem = gameforge.locale.skeleton_gem.talk_about_skeleton_gem
locale.skeleton_gem.i_dont_have_the_skeleton_gem_yet = gameforge.locale.skeleton_gem.i_dont_have_the_skeleton_gem_yet
locale.skeleton_gem.i_have_the_skeleton_gem = gameforge.locale.skeleton_gem.i_have_the_skeleton_gem
locale.skeleton_gem.START_say = gameforge.locale.skeleton_gem.start_say
locale.skeleton_gem.START_find_peddler_label = gameforge.locale.skeleton_gem.start_find_peddler_label
locale.skeleton_gem.START_find_peddler_text = locale.NOTICE_COLOR .. gameforge.locale.skeleton_gem.start_find_peddler_text_1 .. locale.NORMAL_COLOR .. gameforge.locale.skeleton_gem.start_find_peddler_text_2
locale.skeleton_gem.ORDER_say = gameforge.locale.skeleton_gem.order_say
locale.skeleton_gem.ORDER_say2 = gameforge.locale.skeleton_gem.order_say2
locale.skeleton_gem.ORDER_accept = gameforge.locale.skeleton_gem.order_accept
locale.skeleton_gem.ORDER_refuse = gameforge.locale.skeleton_gem.order_refuse
locale.skeleton_gem.ORDER_accept_answer = gameforge.locale.skeleton_gem.order_accept_answer
locale.skeleton_gem.ORDER_refuse_answer = gameforge.locale.skeleton_gem.order_refuse_answer
locale.skeleton_gem.ORDER_get_skeleton_gem_ = gameforge.locale.skeleton_gem.order_get_skeleton_gem_
locale.skeleton_gem.ORDER_get_skeleton_gem_text = locale.NOTICE_COLOR .. gameforge.locale.skeleton_gem.order_get_skeleton_gem_text
locale.skeleton_gem.ORDER_too_late = gameforge.locale.skeleton_gem.order_too_late
locale.skeleton_gem.ACCEPT_success_say = locale.NOTICE_COLOR .. gameforge.locale.skeleton_gem.accept_success_say_1 .. locale.NORMAL_COLOR .. gameforge.locale.skeleton_gem.accept_success_say_2
locale.skeleton_gem.ACCEPT_failure_say = locale.NOTICE_COLOR .. gameforge.locale.skeleton_gem.accept_failure_say_1 .. locale.NORMAL_COLOR .. gameforge.locale.skeleton_gem.accept_failure_say_2
locale.skeleton_gem.ACCEPT_ask = gameforge.locale.skeleton_gem.accept_ask
locale.skeleton_gem.ACCEPT_success_info_label = gameforge.locale.skeleton_gem.accept_success_info_label
locale.skeleton_gem.ACCEPT_success_info_text = locale.NOTICE_COLOR .. gameforge.locale.skeleton_gem.accept_success_info_text_1 .. locale.NORMAL_COLOR .. gameforge.locale.skeleton_gem.accept_success_info_text_2
locale.skeleton_gem.ACCEPT_failure_info_label = gameforge.locale.skeleton_gem.accept_failure_info_label
locale.skeleton_gem.ACCEPT_failure_info_text = locale.NOTICE_COLOR .. gameforge.locale.skeleton_gem.accept_failure_info_text_1 .. locale.NORMAL_COLOR .. gameforge.locale.skeleton_gem.accept_failure_info_text_2
locale.skeleton_gem.SUCCESS_say = gameforge.locale.skeleton_gem.success_say

locale.ariyeong = {}
locale.ariyeong.start_probability = 3
locale.ariyeong.start_level_begin = 25
locale.ariyeong.start_level_end = 27
locale.ariyeong.end_level = 30
locale.ariyeong.kill_count = 2
locale.ariyeong.event_item = 30101
locale.ariyeong.find_ariyeong_label = gameforge.locale.ariyeong.find_ariyeong_label
locale.ariyeong.find_ariyeong_text = locale.NOTICE_COLOR .. gameforge.locale.ariyeong.find_ariyeong_text_1 .. locale.NORMAL_COLOR .. gameforge.locale.ariyeong.find_ariyeong_text_2
locale.ariyeong.kill_label = gameforge.locale.ariyeong.kill_label
locale.ariyeong.kill_text = locale.NOTICE_COLOR .. gameforge.locale.ariyeong.kill_text_1 .. locale.NORMAL_COLOR .. gameforge.locale.ariyeong.kill_text_2
locale.ariyeong.too_late = gameforge.locale.ariyeong.too_late
locale.ariyeong.success_info_label = gameforge.locale.ariyeong.success_info_label
locale.ariyeong.success_info_text = locale.NOTICE_COLOR .. gameforge.locale.ariyeong.success_info_text_1 .. locale.NORMAL_COLOR .. gameforge.locale.ariyeong.success_info_text_2
locale.ariyeong.failure_info_label = gameforge.locale.ariyeong.failure_info_label
locale.ariyeong.failure_info_text = locale.NOTICE_COLOR .. gameforge.locale.ariyeong.failure_info_text_1 .. locale.NORMAL_COLOR .. gameforge.locale.ariyeong.failure_info_text_2

locale.levelup = {}
locale.levelup.choice1 = gameforge.locale.levelup.choice1
locale.levelup.choice2 = gameforge.locale.levelup.choice2
locale.levelup.slay_them1 = gameforge.locale.levelup.slay_them1
locale.levelup.slay_them2 = gameforge.locale.levelup.slay_them2
locale.levelup.slay_target_is = gameforge.locale.levelup.slay_target_is 
locale.levelup.slay_target_count = gameforge.locale.levelup.slay_target_count
locale.levelup.slayed_them = gameforge.locale.levelup.slayed_them
locale.levelup.remain_count = gameforge.locale.levelup.remain_count
locale.levelup.cause_of_levelup = gameforge.locale.levelup.cause_of_levelup
locale.levelup.receive_direct = gameforge.locale.levelup.receive_direct
locale.levelup.levelup_quest_fail = gameforge.locale.levelup.levelup_quest_fail
locale.levelup.lets_go = gameforge.locale.levelup.lets_go
locale.levelup.kill_count = gameforge.locale.levelup.kill_count
locale.levelup.prev_quest1 = gameforge.locale.levelup.prev_quest1
locale.levelup.prev_quest2 = gameforge.locale.levelup.prev_quest2
locale.levelup.prev_quest_info = gameforge.locale.levelup.prev_quest_info
locale.levelup.prev_quest_go = gameforge.locale.levelup.prev_quest_go
locale.levelup.random_item = gameforge.locale.levelup.random_item

locale.stash = {}
locale.stash.buy_silver_and_gold_bar = gameforge.locale.stash.buy_silver_and_gold_bar
locale.stash.gold_bar_beginner_info = gameforge.locale.stash.gold_bar_beginner_info
locale.stash.enlarge_first1_cannot = gameforge.locale.stash.enlarge_first1_cannot
locale.stash.greet1 = gameforge.locale.stash.greet1
locale.stash.not_enough_money = gameforge.locale.stash.not_enough_money
locale.stash.pay_ok = gameforge.locale.stash.pay_ok
locale.stash.pay_no = gameforge.locale.stash.pay_no
locale.stash.first_open = gameforge.locale.stash.first_open
locale.stash.dont_open = gameforge.locale.stash.dont_open
locale.stash.greet2 = gameforge.locale.stash.greet2
locale.stash.beginner_info = gameforge.locale.stash.beginner_info
locale.stash.enlarge = gameforge.locale.stash.enlarge
locale.stash.nomatter = gameforge.locale.stash.nomatter
locale.stash.enlarge_first1 = gameforge.locale.stash.enlarge_first1
locale.stash.enlarge_item1 = 50
locale.stash.enlarge_item2 = 5030
locale.stash.enlarge_first2 = gameforge.locale.stash.enlarge_first2
locale.stash.enlarge_first3 = gameforge.locale.stash.enlarge_first3
locale.stash.enlarge_try_ok = gameforge.locale.stash.enlarge_try_ok
locale.stash.enlarge_try_no = gameforge.locale.stash.enlarge_try_no
locale.stash.enlarge_try_ok_answer = gameforge.locale.stash.enlarge_try_ok_answer
locale.stash.enlarge_1_title = gameforge.locale.stash.enlarge_1_title
locale.stash.enlarge_1_counter = gameforge.locale.stash.enlarge_1_counter
locale.stash.enlarge_1_item = gameforge.locale.stash.enlarge_1_item
locale.stash.enlarge_1_timer = gameforge.locale.stash.enlarge_1_timer
locale.stash.enlarge_no_need = gameforge.locale.stash.enlarge_no_need
locale.stash.greet3 = gameforge.locale.stash.greet3
locale.stash.enlarge_2_no_mark = gameforge.locale.stash.enlarge_2_no_mark
locale.stash.enlarge_2_again = gameforge.locale.stash.enlarge_2_again
locale.stash.enlarge_2_title = gameforge.locale.stash.enlarge_2_title
locale.stash.enlarge_2_item = 60002
locale.stash.enlarge_2_mark_item = 60003
locale.stash.enlarge_2_have_mark = c_item_name(locale.stash.enlarge_2_mark_item .. gameforge.locale.stash.enlarge_2_have_mark)
locale.stash.enlarge_2_no_mark2 = gameforge.locale.stash.enlarge_2_no_mark2
locale.stash.enlarge_2_have_mark2 = gameforge.locale.stash.enlarge_2_have_mark2
locale.stash.enlarge_2_have_mark3 = gameforge.locale.stash.enlarge_2_have_mark3
locale.stash.enlarge_2_msg1 = gameforge.locale.stash.enlarge_2_msg1
locale.stash.enlarge_2_msg2 = gameforge.locale.stash.enlarge_2_msg2
locale.stash.greet4 = gameforge.locale.stash.greet4
locale.stash.enlarge_3_msg1 = gameforge.locale.stash.enlarge_3_msg1
locale.stash.enlarge_3_title = gameforge.locale.stash.enlarge_3_title
locale.stash.enlarge_3_counter = gameforge.locale.stash.enlarge_3_counter
locale.stash.enlarge_3_timer = gameforge.locale.stash.enlarge_3_timer
locale.stash.enlarge_4_msg = gameforge.locale.stash.enlarge_4_msg
locale.stash.enlarge_2_recommendation = gameforge.locale.stash.enlarge_2_recommendation
locale.stash.enlarge_2_oldwoman_greet = gameforge.locale.stash.enlarge_2_oldwoman_greet
locale.stash.enlarge_2_oldwoman_reject = gameforge.locale.stash.enlarge_2_oldwoman_reject
locale.stash.enlarge_2_oldwoman_title1 = gameforge.locale.stash.enlarge_2_oldwoman_title1
locale.stash.enlarge_2_oldwoman_title2 = gameforge.locale.stash.enlarge_2_oldwoman_title2
locale.stash.enlarge_2_oldwoman_accept = gameforge.locale.stash.enlarge_2_oldwoman_accept
locale.stash.enlarge_1_info1 = gameforge.locale.stash.enlarge_1_info1
locale.stash.enlarge_1_info2 = gameforge.locale.stash.enlarge_1_info2
locale.stash.enlarge_1_take_bear = gameforge.locale.stash.enlarge_1_take_bear
locale.stash.enlarge_1_success = gameforge.locale.stash.enlarge_1_success
locale.stash.enlarge_1_notyet = gameforge.locale.stash.enlarge_1_notyet
locale.stash.enlarge_1_getone = gameforge.locale.stash.enlarge_1_getone
locale.stash.enlarge_1_complete = gameforge.locale.stash.enlarge_1_complete
locale.stash.enlarge_1_fail_info = gameforge.locale.stash.enlarge_1_fail_info
locale.stash.enlarge_1_fail_msg = gameforge.locale.stash.enlarge_1_fail_msg
locale.stash.enlarge_3_complete = gameforge.locale.stash.enlarge_3_complete
locale.stash.enlarge_3_success = gameforge.locale.stash.enlarge_3_success
locale.stash.enlarge_3_notyet = gameforge.locale.stash.enlarge_3_notyet
locale.stash.open_mall = gameforge.locale.stash.open_mall

locale.guild = {}
locale.guild.guild_master_greet = gameforge.locale.guild.guild_master_greet
locale.guild.disband = gameforge.locale.guild.disband
locale.guild.cancel = gameforge.locale.guild.cancel
locale.guild.yes = gameforge.locale.guild.yes
locale.guild.no = gameforge.locale.guild.no
locale.guild.disband_confirm = gameforge.locale.guild.disband_confirm
locale.guild.disband_msg = gameforge.locale.guild.disband_msg
locale.guild.guild_member_greet = gameforge.locale.guild.guild_member_greet
locale.guild.withdraw = gameforge.locale.guild.withdraw
locale.guild.withdraw_confirm = gameforge.locale.guild.withdraw_confirm
locale.guild.withdraw_msg = gameforge.locale.guild.withdraw_msg
locale.guild.noguild_greet = gameforge.locale.guild.noguild_greet
locale.guild.create = gameforge.locale.guild.create
locale.guild.create_confirm = gameforge.locale.guild.create_confirm
locale.guild.create_not_enough_money = gameforge.locale.guild.create_not_enough_money
locale.guild.not_enough_leadership = gameforge.locale.guild.not_enough_leadership
locale.guild.no_guild_create_item = gameforge.locale.guild.no_guild_create_item
locale.guild.create_confirm_for_china = gameforge.locale.guild.create_confirm_for_china
locale.guild.cannot_create_guild_withdraw_delay = gameforge.locale.guild.cannot_create_guild_withdraw_delay
locale.guild.cannot_create_guild_disband_delay = gameforge.locale.guild.cannot_create_guild_disband_delay
locale.guild.war_entry_ask_head = gameforge.locale.guild.war_entry_ask_head
locale.guild.war_entry_ask_tail = gameforge.locale.guild.war_entry_ask_tail
locale.guild.war_list_button = gameforge.locale.guild.war_list_button
locale.guild.war_list_none = gameforge.locale.guild.war_list_none
locale.guild.war_list_choose = gameforge.locale.guild.war_list_choose
locale.guild.war_join_request = gameforge.locale.guild.war_join_request
locale.guild.war_over = gameforge.locale.guild.war_over
locale.guild.war_bet_list_button = gameforge.locale.guild.war_bet_list_button
locale.guild.war_bet_info = gameforge.locale.guild.war_bet_info
locale.guild.war_bet_no_money = gameforge.locale.guild.war_bet_no_money
locale.guild.war_bet_price = gameforge.locale.guild.war_bet_price
locale.guild.war_bet_done = gameforge.locale.guild.war_bet_done
locale.guild.war_bet_list_none = gameforge.locale.guild.war_bet_list_none
locale.guild.war_bet_list_choose = gameforge.locale.guild.war_bet_list_choose
locale.guild.war_bet_already = gameforge.locale.guild.war_bet_already
locale.guild.war_bet_assume1 = gameforge.locale.guild.war_bet_assume1
locale.guild.war_bet_assume2 = gameforge.locale.guild.war_bet_assume2
locale.guild.war_bet_assume3 = gameforge.locale.guild.war_bet_assume3

locale.oldwoman = {}
locale.oldwoman.no_matter = gameforge.locale.oldwoman.no_matter
locale.oldwoman.skill_reset1 = gameforge.locale.oldwoman.skill_reset1
locale.oldwoman.skill_reset2 = gameforge.locale.oldwoman.skill_reset2
locale.oldwoman.skill_reset_ok = gameforge.locale.oldwoman.skill_reset_ok
locale.oldwoman.skill_reset_no = gameforge.locale.oldwoman.skill_reset_no
locale.oldwoman.not_enough_money = gameforge.locale.oldwoman.not_enough_money
 
locale.skill_group = {}
locale.skill_group.lets_join_skill_group = {
	gameforge.locale.skill_group.lets_join_skill_group_1,
	gameforge.locale.skill_group.lets_join_skill_group_2,
	gameforge.locale.skill_group.lets_join_skill_group_3,
	gameforge.locale.skill_group.lets_join_skill_group_4
}
locale.skill_group.invite = gameforge.locale.skill_group.invite
locale.skill_group.board = gameforge.locale.skill_group.board
locale.skill_group.dialog = {{
	[WARRIOR] = {
		{
			gameforge.locale.skill_group.dialog_warrior_1,
			gameforge.locale.skill_group.dialog_warrior_2,
		},
		{
			gameforge.locale.skill_group.dialog_warrior_3,
			gameforge.locale.skill_group.dialog_warrior_4,
		},
		gameforge.locale.skill_group.dialog_warrior_5,
	},
	[ASSASSIN] = {
		{
			gameforge.locale.skill_group.dialog_assassin_1,
			gameforge.locale.skill_group.dialog_assassin_2,
		},
		{
			gameforge.locale.skill_group.dialog_assassin_3,
			gameforge.locale.skill_group.dialog_assassin_4,
		},
		gameforge.locale.skill_group.dialog_assassin_5,
	},
	[SURA] = {
		{
			gameforge.locale.skill_group.dialog_sura_1,
			gameforge.locale.skill_group.dialog_sura_2,
		},
		{
			gameforge.locale.skill_group.dialog_sura_3,
			gameforge.locale.skill_group.dialog_sura_4,
		},
		gameforge.locale.skill_group.dialog_sura_5,
	},
	[SHAMAN] = {
		{
			gameforge.locale.skill_group.dialog_shaman_1,
			gameforge.locale.skill_group.dialog_shaman_2,
		},
		{
			gameforge.locale.skill_group.dialog_shaman_3,
			gameforge.locale.skill_group.dialog_shaman_4,
		},
		gameforge.locale.skill_group.dialog_shaman_5,
	}
}}

locale.neutral_warp = {}
locale.neutral_warp.greet = gameforge.locale.neutral_warp.greet 
locale.neutral_warp.go = gameforge.locale.neutral_warp.go
locale.neutral_warp.not_go = gameforge.locale.neutral_warp.not_go
locale.neutral_warp.where_to_go = gameforge.locale.neutral_warp.where_to_go
locale.neutral_warp.money_need1 = gameforge.locale.neutral_warp.money_need1
locale.neutral_warp.money_need2 = gameforge.locale.neutral_warp.money_need2
locale.neutral_warp.cannot_go_yet = gameforge.locale.neutral_warp.cannot_go_yet

locale.blacksmith = {}
locale.blacksmith.refine_info = gameforge.locale.blacksmith.refine_info

locale.monster_chat = { 
	[301] = {
		gameforge.locale.monster_chat_301_1,
		gameforge.locale.monster_chat_301_2,
		gameforge.locale.monster_chat_301_3,
		gameforge.locale.monster_chat_301_4,
		gameforge.locale.monster_chat_301_5
	},
	[302] = {
		gameforge.locale.monster_chat_302_1,
		gameforge.locale.monster_chat_302_2,
		gameforge.locale.monster_chat_302_3,
		gameforge.locale.monster_chat_302_4,
		gameforge.locale.monster_chat_302_5,
		gameforge.locale.monster_chat_302_6
	},
	[303] = {
		gameforge.locale.monster_chat_303_1,
		gameforge.locale.monster_chat_303_2,
		gameforge.locale.monster_chat_303_3,
		gameforge.locale.monster_chat_303_4,
		gameforge.locale.monster_chat_303_5,
		gameforge.locale.monster_chat_303_6
	},
	[304] = {
		gameforge.locale.monster_chat_304_1,
		gameforge.locale.monster_chat_304_2,
		gameforge.locale.monster_chat_304_3,
		gameforge.locale.monster_chat_304_4,
		gameforge.locale.monster_chat_304_5,
		gameforge.locale.monster_chat_304_6
	},
	[305] = {
		gameforge.locale.monster_chat_305_1,
		gameforge.locale.monster_chat_305_2,
		gameforge.locale.monster_chat_305_3,
		gameforge.locale.monster_chat_305_4,
		gameforge.locale.monster_chat_305_5,
		gameforge.locale.monster_chat_305_6
	},
	[306] = {
		gameforge.locale.monster_chat_306_1,
		gameforge.locale.monster_chat_306_2,
		gameforge.locale.monster_chat_306_3,
		gameforge.locale.monster_chat_306_4,
		gameforge.locale.monster_chat_306_5,
		gameforge.locale.monster_chat_306_6
	},
	[307] = {
		gameforge.locale.monster_chat_307_1,
		gameforge.locale.monster_chat_307_2,
		gameforge.locale.monster_chat_307_3,
		gameforge.locale.monster_chat_307_4,
		gameforge.locale.monster_chat_307_5,
		gameforge.locale.monster_chat_307_6
	},
	[394] = {
		gameforge.locale.monster_chat_394_1,
		gameforge.locale.monster_chat_394_2,
		gameforge.locale.monster_chat_394_3,
		gameforge.locale.monster_chat_394_4,
		gameforge.locale.monster_chat_394_5,
		gameforge.locale.monster_chat_394_6
	},
	[401] = {
		gameforge.locale.monster_chat_401_1,
		gameforge.locale.monster_chat_401_2,
		gameforge.locale.monster_chat_401_3,
		gameforge.locale.monster_chat_401_4,
		gameforge.locale.monster_chat_401_5,
		gameforge.locale.monster_chat_401_6
	},
	[402] = {
		gameforge.locale.monster_chat_402_1,
		gameforge.locale.monster_chat_402_2,
		gameforge.locale.monster_chat_402_3,
		gameforge.locale.monster_chat_402_4,
		gameforge.locale.monster_chat_402_5,
		gameforge.locale.monster_chat_402_6
	},
	[403] = {
		gameforge.locale.monster_chat_403_1,
		gameforge.locale.monster_chat_403_2,
		gameforge.locale.monster_chat_403_3,
		gameforge.locale.monster_chat_403_4,
		gameforge.locale.monster_chat_403_5,
		gameforge.locale.monster_chat_403_6
	},
	[404] = {
		gameforge.locale.monster_chat_404_1,
		gameforge.locale.monster_chat_404_2,
		gameforge.locale.monster_chat_404_3,
		gameforge.locale.monster_chat_404_4,
		gameforge.locale.monster_chat_404_5,
		gameforge.locale.monster_chat_404_6
	},
	[405] = {
		gameforge.locale.monster_chat_405_1,
		gameforge.locale.monster_chat_405_2,
		gameforge.locale.monster_chat_405_3,
		gameforge.locale.monster_chat_405_4,
		gameforge.locale.monster_chat_405_5,
		gameforge.locale.monster_chat_405_6
	},
	[406] = {
		gameforge.locale.monster_chat_406_1,
		gameforge.locale.monster_chat_406_2,
		gameforge.locale.monster_chat_406_3,
		gameforge.locale.monster_chat_406_4,
		gameforge.locale.monster_chat_406_5,
		gameforge.locale.monster_chat_406_6
	},
	[491] = {
		gameforge.locale.monster_chat_491_1,
		gameforge.locale.monster_chat_491_2,
		gameforge.locale.monster_chat_491_3,
		gameforge.locale.monster_chat_491_4,
		gameforge.locale.monster_chat_491_5,
		gameforge.locale.monster_chat_491_6
	},
	[492] = {
		gameforge.locale.monster_chat_492_1,
		gameforge.locale.monster_chat_492_2,
		gameforge.locale.monster_chat_492_3,
		gameforge.locale.monster_chat_492_4,
		gameforge.locale.monster_chat_492_5,
		gameforge.locale.monster_chat_492_6
	},
	[493] = {
		gameforge.locale.monster_chat_493_1,
		gameforge.locale.monster_chat_493_2,
		gameforge.locale.monster_chat_493_3,
		gameforge.locale.monster_chat_493_4,
		gameforge.locale.monster_chat_493_5,
		gameforge.locale.monster_chat_493_6
	},
	[494] = {
		gameforge.locale.monster_chat_494_1,
		gameforge.locale.monster_chat_494_2,
		gameforge.locale.monster_chat_494_3,
		gameforge.locale.monster_chat_494_4,
		gameforge.locale.monster_chat_494_5,
		gameforge.locale.monster_chat_494_6
	},
	[501] = {
		gameforge.locale.monster_chat_501_1,
		gameforge.locale.monster_chat_501_2,
		gameforge.locale.monster_chat_501_3,
		gameforge.locale.monster_chat_501_4,
		gameforge.locale.monster_chat_501_5,
		gameforge.locale.monster_chat_501_6
	},
	[502] = {
		gameforge.locale.monster_chat_502_1,
		gameforge.locale.monster_chat_502_2,
		gameforge.locale.monster_chat_502_3,
		gameforge.locale.monster_chat_502_4,
		gameforge.locale.monster_chat_502_5,
		gameforge.locale.monster_chat_502_6
	},
	[503] = {
		gameforge.locale.monster_chat_503_1,
		gameforge.locale.monster_chat_503_2,
		gameforge.locale.monster_chat_503_3,
		gameforge.locale.monster_chat_503_4,
		gameforge.locale.monster_chat_503_5,
		gameforge.locale.monster_chat_503_6
	},
	[504] = {
		gameforge.locale.monster_chat_504_1,
		gameforge.locale.monster_chat_504_2,
		gameforge.locale.monster_chat_504_3,
		gameforge.locale.monster_chat_504_4,
		gameforge.locale.monster_chat_504_5,
		gameforge.locale.monster_chat_504_6
	},
	[601] = {
		gameforge.locale.monster_chat_601_1,
		gameforge.locale.monster_chat_601_2,
		gameforge.locale.monster_chat_601_3,
		gameforge.locale.monster_chat_601_4,
		gameforge.locale.monster_chat_601_5,
		gameforge.locale.monster_chat_601_6
	},
	[601] = {
		gameforge.locale.monster_chat_601_7,
		gameforge.locale.monster_chat_602_1,
		gameforge.locale.monster_chat_602_2,
		gameforge.locale.monster_chat_602_3,
		gameforge.locale.monster_chat_602_4,
		gameforge.locale.monster_chat_602_5,
		gameforge.locale.monster_chat_602_6
	},
	[603] = {
		gameforge.locale.monster_chat_603_1,
		gameforge.locale.monster_chat_603_2,
		gameforge.locale.monster_chat_603_3,
		gameforge.locale.monster_chat_603_4,
		gameforge.locale.monster_chat_603_5,
		gameforge.locale.monster_chat_603_6
	},
	[604] = {
		gameforge.locale.monster_chat_604_1,
		gameforge.locale.monster_chat_604_2,
		gameforge.locale.monster_chat_604_3,
		gameforge.locale.monster_chat_604_4,
		gameforge.locale.monster_chat_604_5,
		gameforge.locale.monster_chat_604_6
	},
	[631] = {
		gameforge.locale.monster_chat_631_1,
		gameforge.locale.monster_chat_631_2,
		gameforge.locale.monster_chat_631_3,
		gameforge.locale.monster_chat_631_4,
		gameforge.locale.monster_chat_631_5,
		gameforge.locale.monster_chat_631_6
	},
	[632] = {
		gameforge.locale.monster_chat_632_1,
		gameforge.locale.monster_chat_632_2,
		gameforge.locale.monster_chat_632_3,
		gameforge.locale.monster_chat_632_4,
		gameforge.locale.monster_chat_632_5,
		gameforge.locale.monster_chat_632_6
	},
	[633] = {
		gameforge.locale.monster_chat_633_1,
		gameforge.locale.monster_chat_633_2,
		gameforge.locale.monster_chat_633_3,
		gameforge.locale.monster_chat_633_4,
		gameforge.locale.monster_chat_633_5,
		gameforge.locale.monster_chat_633_6
	},
	[634] = {
		gameforge.locale.monster_chat_634_1,
		gameforge.locale.monster_chat_634_2,
		gameforge.locale.monster_chat_634_3,
		gameforge.locale.monster_chat_634_4,
		gameforge.locale.monster_chat_634_5,
		gameforge.locale.monster_chat_634_6
	},
	[635] = {
		gameforge.locale.monster_chat_635_1,
		gameforge.locale.monster_chat_635_2,
		gameforge.locale.monster_chat_635_3,
		gameforge.locale.monster_chat_635_4,
		gameforge.locale.monster_chat_635_5,
		gameforge.locale.monster_chat_635_6
	},
	[636] = {
		gameforge.locale.monster_chat_636_1,
		gameforge.locale.monster_chat_636_2,
		gameforge.locale.monster_chat_636_3,
		gameforge.locale.monster_chat_636_4,
		gameforge.locale.monster_chat_636_5,
		gameforge.locale.monster_chat_636_6
	},
	[636] = {
		gameforge.locale.monster_chat_636_7,
		gameforge.locale.monster_chat_637_1,
		gameforge.locale.monster_chat_637_2,
		gameforge.locale.monster_chat_637_3,
		gameforge.locale.monster_chat_637_4,
		gameforge.locale.monster_chat_637_5,
		gameforge.locale.monster_chat_637_6
	},
	[691] = {
		gameforge.locale.monster_chat_691_1,
		gameforge.locale.monster_chat_691_2,
		gameforge.locale.monster_chat_691_3,
		gameforge.locale.monster_chat_691_4,
		gameforge.locale.monster_chat_691_5,
		gameforge.locale.monster_chat_691_6
	},
	[701] = {
		gameforge.locale.monster_chat_701_1,
		gameforge.locale.monster_chat_701_2,
		gameforge.locale.monster_chat_701_3,
		gameforge.locale.monster_chat_701_4,
		gameforge.locale.monster_chat_701_5,
		gameforge.locale.monster_chat_701_6
	},
	[702] = {
		gameforge.locale.monster_chat_702_1,
		gameforge.locale.monster_chat_702_2,
		gameforge.locale.monster_chat_702_3,
		gameforge.locale.monster_chat_702_4,
		gameforge.locale.monster_chat_702_5,
		gameforge.locale.monster_chat_702_6
	},
	[703] = {
		gameforge.locale.monster_chat_703_1,
		gameforge.locale.monster_chat_703_2,
		gameforge.locale.monster_chat_703_3,
		gameforge.locale.monster_chat_703_4,
		gameforge.locale.monster_chat_703_5,
		gameforge.locale.monster_chat_703_6
	},
	[704] = {
		gameforge.locale.monster_chat_704_1,
		gameforge.locale.monster_chat_704_2,
		gameforge.locale.monster_chat_704_3,
		gameforge.locale.monster_chat_704_4,
		gameforge.locale.monster_chat_704_5,
		gameforge.locale.monster_chat_704_6
	},
	[705] = {
		gameforge.locale.monster_chat_705_1,
		gameforge.locale.monster_chat_705_2,
		gameforge.locale.monster_chat_705_3,
		gameforge.locale.monster_chat_705_4,
		gameforge.locale.monster_chat_705_5,
		gameforge.locale.monster_chat_705_6
	},
	[706] = {
		gameforge.locale.monster_chat_706_1,
		gameforge.locale.monster_chat_706_2,
		gameforge.locale.monster_chat_706_3,
		gameforge.locale.monster_chat_706_4,
		gameforge.locale.monster_chat_706_5,
		gameforge.locale.monster_chat_706_6
	},
	[707] = {
		gameforge.locale.monster_chat_707_1,
		gameforge.locale.monster_chat_707_2,
		gameforge.locale.monster_chat_707_3,
		gameforge.locale.monster_chat_707_4,
		gameforge.locale.monster_chat_707_5,
		gameforge.locale.monster_chat_707_6
	},
	[791] = {
		gameforge.locale.monster_chat_791_1,
		gameforge.locale.monster_chat_791_2,
		gameforge.locale.monster_chat_791_3,
		gameforge.locale.monster_chat_791_4,
		gameforge.locale.monster_chat_791_5,
		gameforge.locale.monster_chat_791_6
	},
	[901] = {
		gameforge.locale.monster_chat_901_1,
		gameforge.locale.monster_chat_901_2,
		gameforge.locale.monster_chat_901_3,
		gameforge.locale.monster_chat_901_4,
		gameforge.locale.monster_chat_901_5
	},
	[903] = {
		gameforge.locale.monster_chat_903_1,
		gameforge.locale.monster_chat_903_2,
		gameforge.locale.monster_chat_903_3,
		gameforge.locale.monster_chat_903_4,
		gameforge.locale.monster_chat_903_5,
		gameforge.locale.monster_chat_903_6
	},
	[904] = {
		gameforge.locale.monster_chat_904_1,
		gameforge.locale.monster_chat_904_2,
		gameforge.locale.monster_chat_904_3,
		gameforge.locale.monster_chat_904_4,
		gameforge.locale.monster_chat_904_5,
		gameforge.locale.monster_chat_904_6
	},
	[905] = {
		gameforge.locale.monster_chat_905_1,
		gameforge.locale.monster_chat_905_2,
		gameforge.locale.monster_chat_905_3,
		gameforge.locale.monster_chat_905_4,
		gameforge.locale.monster_chat_905_5,
		gameforge.locale.monster_chat_905_6
	},
	[906] = {
		gameforge.locale.monster_chat_906_1,
		gameforge.locale.monster_chat_906_2,
		gameforge.locale.monster_chat_906_3,
		gameforge.locale.monster_chat_906_4,
		gameforge.locale.monster_chat_906_5,
		gameforge.locale.monster_chat_906_6
	},
	[907] = {
		gameforge.locale.monster_chat_907_1,
		gameforge.locale.monster_chat_907_2,
		gameforge.locale.monster_chat_907_3,
		gameforge.locale.monster_chat_907_4,
		gameforge.locale.monster_chat_907_5,
		gameforge.locale.monster_chat_907_6
	},
	[1001] = {
		gameforge.locale.monster_chat_1001_1,
		gameforge.locale.monster_chat_1001_2,
		gameforge.locale.monster_chat_1001_3,
		gameforge.locale.monster_chat_1001_4,
		gameforge.locale.monster_chat_1001_5,
		gameforge.locale.monster_chat_1001_6
	},
	[1002] = {
		gameforge.locale.monster_chat_1002_1,
		gameforge.locale.monster_chat_1002_2,
		gameforge.locale.monster_chat_1002_3,
		gameforge.locale.monster_chat_1002_4,
		gameforge.locale.monster_chat_1002_5
	},
	[1003] = {
		gameforge.locale.monster_chat_1003_1,
		gameforge.locale.monster_chat_1003_2,
		gameforge.locale.monster_chat_1003_3,
		gameforge.locale.monster_chat_1003_4,
		gameforge.locale.monster_chat_1003_5,
		gameforge.locale.monster_chat_1003_6
	},
	[1004] = {
		gameforge.locale.monster_chat_1004_1,
		gameforge.locale.monster_chat_1004_2,
		gameforge.locale.monster_chat_1004_3,
		gameforge.locale.monster_chat_1004_4,
		gameforge.locale.monster_chat_1004_5,
		gameforge.locale.monster_chat_1004_6
	},
	[1035] = {
		gameforge.locale.monster_chat_1035_1,
		gameforge.locale.monster_chat_1035_2,
		gameforge.locale.monster_chat_1035_3,
		gameforge.locale.monster_chat_1035_4,
		gameforge.locale.monster_chat_1035_5,
		gameforge.locale.monster_chat_1035_6
	},
	[1036] = {
		gameforge.locale.monster_chat_1036_1,
		gameforge.locale.monster_chat_1036_2,
		gameforge.locale.monster_chat_1036_3,
		gameforge.locale.monster_chat_1036_4,
		gameforge.locale.monster_chat_1036_5,
		gameforge.locale.monster_chat_1036_6
	},
	[1037] = {
		gameforge.locale.monster_chat_1037_1,
		gameforge.locale.monster_chat_1037_2,
		gameforge.locale.monster_chat_1037_3,
		gameforge.locale.monster_chat_1037_4,
		gameforge.locale.monster_chat_1037_5,
		gameforge.locale.monster_chat_1037_6
	},
	[1038] = {
		gameforge.locale.monster_chat_1038_1,
		gameforge.locale.monster_chat_1038_2,
		gameforge.locale.monster_chat_1038_3,
		gameforge.locale.monster_chat_1038_4,
		gameforge.locale.monster_chat_1038_5,
		gameforge.locale.monster_chat_1038_6
	},
	[1039] = {
		gameforge.locale.monster_chat_1039_1,
		gameforge.locale.monster_chat_1039_2,
		gameforge.locale.monster_chat_1039_3,
		gameforge.locale.monster_chat_1039_4,
		gameforge.locale.monster_chat_1039_5,
		gameforge.locale.monster_chat_1039_6
	},
	[1040] = {
		gameforge.locale.monster_chat_1040_1,
		gameforge.locale.monster_chat_1040_2,
		gameforge.locale.monster_chat_1040_3,
		gameforge.locale.monster_chat_1040_4,
		gameforge.locale.monster_chat_1040_5,
		gameforge.locale.monster_chat_1040_6
	},
	[1041] = {
		gameforge.locale.monster_chat_1041_1,
		gameforge.locale.monster_chat_1041_2,
		gameforge.locale.monster_chat_1041_3,
		gameforge.locale.monster_chat_1041_4,
		gameforge.locale.monster_chat_1041_5,
		gameforge.locale.monster_chat_1041_6
	},
	[1091] = {
		gameforge.locale.monster_chat_1091_1,
		gameforge.locale.monster_chat_1091_2,
		gameforge.locale.monster_chat_1091_3,
		gameforge.locale.monster_chat_1091_4,
		gameforge.locale.monster_chat_1091_5,
		gameforge.locale.monster_chat_1091_6
	},
	[1093] = {
		gameforge.locale.monster_chat_1093_1,
		gameforge.locale.monster_chat_1093_2,
		gameforge.locale.monster_chat_1093_3,
		gameforge.locale.monster_chat_1093_4,
		gameforge.locale.monster_chat_1093_5,
		gameforge.locale.monster_chat_1093_6
	},
	[1105] = {
		gameforge.locale.monster_chat_1105_1,
		gameforge.locale.monster_chat_1105_2,
		gameforge.locale.monster_chat_1105_3,
		gameforge.locale.monster_chat_1105_4,
		gameforge.locale.monster_chat_1105_5,
		gameforge.locale.monster_chat_1105_6
	},
	[1106] = {
		gameforge.locale.monster_chat_1106_1,
		gameforge.locale.monster_chat_1106_2,
		gameforge.locale.monster_chat_1106_3,
		gameforge.locale.monster_chat_1106_4,
		gameforge.locale.monster_chat_1106_5,
		gameforge.locale.monster_chat_1106_6
	},
	[1191] = {
		gameforge.locale.monster_chat_1191_1,
		gameforge.locale.monster_chat_1191_2,
		gameforge.locale.monster_chat_1191_3,
		gameforge.locale.monster_chat_1191_4,
		gameforge.locale.monster_chat_1191_5,
		gameforge.locale.monster_chat_1191_6
	},
	[1301] = {
		gameforge.locale.monster_chat_1301_1,
		gameforge.locale.monster_chat_1301_2,
		gameforge.locale.monster_chat_1301_3,
		gameforge.locale.monster_chat_1301_4,
		gameforge.locale.monster_chat_1301_5,
		gameforge.locale.monster_chat_1301_6
	},
	[1302] = {
		gameforge.locale.monster_chat_1302_1,
		gameforge.locale.monster_chat_1302_2,
		gameforge.locale.monster_chat_1302_3,
		gameforge.locale.monster_chat_1302_4,
		gameforge.locale.monster_chat_1302_5,
		gameforge.locale.monster_chat_1302_6
	},
	[1303] = {
		gameforge.locale.monster_chat_1303_1,
		gameforge.locale.monster_chat_1303_2,
		gameforge.locale.monster_chat_1303_3,
		gameforge.locale.monster_chat_1303_4,
		gameforge.locale.monster_chat_1303_5,
		gameforge.locale.monster_chat_1303_6
	},
	[1305] = {
		gameforge.locale.monster_chat_1305_1,
		gameforge.locale.monster_chat_1305_2,
		gameforge.locale.monster_chat_1305_3,
		gameforge.locale.monster_chat_1305_4,
		gameforge.locale.monster_chat_1305_5,
		gameforge.locale.monster_chat_1305_6
	},
	[1901] = {
		gameforge.locale.monster_chat_1901_1,
		gameforge.locale.monster_chat_1901_2,
		gameforge.locale.monster_chat_1901_3,
		gameforge.locale.monster_chat_1901_4,
		gameforge.locale.monster_chat_1901_5,
		gameforge.locale.monster_chat_1901_6
	},
	[2091] = {
		gameforge.locale.monster_chat_2091_1,
		gameforge.locale.monster_chat_2091_2,
		gameforge.locale.monster_chat_2091_3,
		gameforge.locale.monster_chat_2091_4,
		gameforge.locale.monster_chat_2091_5,
		gameforge.locale.monster_chat_2091_6
	},
	[2092] = {
		gameforge.locale.monster_chat_2092_1,
		gameforge.locale.monster_chat_2092_2,
		gameforge.locale.monster_chat_2092_3,
		gameforge.locale.monster_chat_2092_4,
		gameforge.locale.monster_chat_2092_5,
		gameforge.locale.monster_chat_2092_6
	},
	[2104] = {
		gameforge.locale.monster_chat_2104_1,
		gameforge.locale.monster_chat_2104_2,
		gameforge.locale.monster_chat_2104_3,
		gameforge.locale.monster_chat_2104_4,
		gameforge.locale.monster_chat_2104_5,
		gameforge.locale.monster_chat_2104_6
	},
	[2105] = {
		gameforge.locale.monster_chat_2105_1,
		gameforge.locale.monster_chat_2105_2,
		gameforge.locale.monster_chat_2105_3,
		gameforge.locale.monster_chat_2105_4,
		gameforge.locale.monster_chat_2105_5
	},
	[2106] = {
		gameforge.locale.monster_chat_2106_1,
		gameforge.locale.monster_chat_2106_2,
		gameforge.locale.monster_chat_2106_3,
		gameforge.locale.monster_chat_2106_4,
		gameforge.locale.monster_chat_2106_5,
		gameforge.locale.monster_chat_2106_6
	},
	[2107] = {
		gameforge.locale.monster_chat_2107_1,
		gameforge.locale.monster_chat_2107_2,
		gameforge.locale.monster_chat_2107_3,
		gameforge.locale.monster_chat_2107_4,
		gameforge.locale.monster_chat_2107_5,
		gameforge.locale.monster_chat_2107_6
	},
	[2108] = {
		gameforge.locale.monster_chat_2108_1,
		gameforge.locale.monster_chat_2108_2,
		gameforge.locale.monster_chat_2108_3,
		gameforge.locale.monster_chat_2108_4,
		gameforge.locale.monster_chat_2108_5,
		gameforge.locale.monster_chat_2108_6
	},
	[2191] = {
		gameforge.locale.monster_chat_2191_1,
		gameforge.locale.monster_chat_2191_2,
		gameforge.locale.monster_chat_2191_3,
		gameforge.locale.monster_chat_2191_4,
		gameforge.locale.monster_chat_2191_5,
		gameforge.locale.monster_chat_2191_6
	},
	[2202] = {
		gameforge.locale.monster_chat_2202_1,
		gameforge.locale.monster_chat_2202_2,
		gameforge.locale.monster_chat_2202_3,
		gameforge.locale.monster_chat_2202_4,
		gameforge.locale.monster_chat_2202_5,
		gameforge.locale.monster_chat_2202_6
	},
	[2204] = {
		gameforge.locale.monster_chat_2204_1,
		gameforge.locale.monster_chat_2204_2,
		gameforge.locale.monster_chat_2204_3,
		gameforge.locale.monster_chat_2204_4,
		gameforge.locale.monster_chat_2204_5,
		gameforge.locale.monster_chat_2204_6
	},
	[2205] = {
		gameforge.locale.monster_chat_2205_1,
		gameforge.locale.monster_chat_2205_2,
		gameforge.locale.monster_chat_2205_3,
		gameforge.locale.monster_chat_2205_4,
		gameforge.locale.monster_chat_2205_5,
		gameforge.locale.monster_chat_2205_6
	},
	[2206] = {
		gameforge.locale.monster_chat_2206_1,
		gameforge.locale.monster_chat_2206_2,
		gameforge.locale.monster_chat_2206_3,
		gameforge.locale.monster_chat_2206_4,
		gameforge.locale.monster_chat_2206_5,
		gameforge.locale.monster_chat_2206_6
	},
	[2291] = {
		gameforge.locale.monster_chat_2291_1,
		gameforge.locale.monster_chat_2291_2,
		gameforge.locale.monster_chat_2291_3,
		gameforge.locale.monster_chat_2291_4,
		gameforge.locale.monster_chat_2291_5,
		gameforge.locale.monster_chat_2291_6
	},
	[20001] = {
		gameforge.locale.monster_chat_20001_1,
		gameforge.locale.monster_chat_20001_2,
		gameforge.locale.monster_chat_20001_3,
		gameforge.locale.monster_chat_20001_4,
		gameforge.locale.monster_chat_20001_5
	},
	[20002] = {
		gameforge.locale.monster_chat_20002_1,
		gameforge.locale.monster_chat_20002_2,
		gameforge.locale.monster_chat_20002_3,
		gameforge.locale.monster_chat_20002_4,
		gameforge.locale.monster_chat_20002_5
	},
	[20003] = {
		gameforge.locale.monster_chat_20003_1,
		gameforge.locale.monster_chat_20003_2,
		gameforge.locale.monster_chat_20003_3,
		gameforge.locale.monster_chat_20003_4,
		gameforge.locale.monster_chat_20003_5
	},
	[20004] = {
		gameforge.locale.monster_chat_20004_1,
		gameforge.locale.monster_chat_20004_2,
		gameforge.locale.monster_chat_20004_3,
		gameforge.locale.monster_chat_20004_4,
		gameforge.locale.monster_chat_20004_5
	},
	[20005] = {
		gameforge.locale.monster_chat_20005_1,
		gameforge.locale.monster_chat_20005_2,
		gameforge.locale.monster_chat_20005_3,
		gameforge.locale.monster_chat_20005_4,
		gameforge.locale.monster_chat_20005_5
	},
	[20006] = {
		gameforge.locale.monster_chat_20006_1,
		gameforge.locale.monster_chat_20006_2,
		gameforge.locale.monster_chat_20006_3,
		gameforge.locale.monster_chat_20006_4,
		gameforge.locale.monster_chat_20006_5
	},
	[20007] = {
		gameforge.locale.monster_chat_20007_1,
		gameforge.locale.monster_chat_20007_2,
		gameforge.locale.monster_chat_20007_3,
		gameforge.locale.monster_chat_20007_4,
		gameforge.locale.monster_chat_20007_5
	},
	[20008] = {
		gameforge.locale.monster_chat_20008_1,
		gameforge.locale.monster_chat_20008_2,
		gameforge.locale.monster_chat_20008_3,
		gameforge.locale.monster_chat_20008_4,
		gameforge.locale.monster_chat_20008_5
	},
	[20009] = {
		gameforge.locale.monster_chat_20009_1,
		gameforge.locale.monster_chat_20009_2,
		gameforge.locale.monster_chat_20009_3,
		gameforge.locale.monster_chat_20009_4,
		gameforge.locale.monster_chat_20009_5
	},
	[20010] = {
		gameforge.locale.monster_chat_20010_1,
		gameforge.locale.monster_chat_20010_2,
		gameforge.locale.monster_chat_20010_3,
		gameforge.locale.monster_chat_20010_4,
		gameforge.locale.monster_chat_20010_5
	},
	[20011] = {
		gameforge.locale.monster_chat_20011_1,
		gameforge.locale.monster_chat_20011_2,
		gameforge.locale.monster_chat_20011_3,
		gameforge.locale.monster_chat_20011_4,
		gameforge.locale.monster_chat_20011_5
	},
	[20012] = {
		gameforge.locale.monster_chat_20012_1,
		gameforge.locale.monster_chat_20012_2,
		gameforge.locale.monster_chat_20012_3,
		gameforge.locale.monster_chat_20012_4,
		gameforge.locale.monster_chat_20012_5
	},
	[20013] = {
		gameforge.locale.monster_chat_20013_1,
		gameforge.locale.monster_chat_20013_2,
		gameforge.locale.monster_chat_20013_3,
		gameforge.locale.monster_chat_20013_4,
		gameforge.locale.monster_chat_20013_5
	},
	[20014] = {
		gameforge.locale.monster_chat_20014_1,
		gameforge.locale.monster_chat_20014_2,
		gameforge.locale.monster_chat_20014_3,
		gameforge.locale.monster_chat_20014_4,
		gameforge.locale.monster_chat_20014_5
	},
	[20015] = {
		gameforge.locale.monster_chat_20015_1,
		gameforge.locale.monster_chat_20015_2,
		gameforge.locale.monster_chat_20015_3,
		gameforge.locale.monster_chat_20015_4,
		gameforge.locale.monster_chat_20015_5
	},
	[20016] = {
		gameforge.locale.monster_chat_20016_1,
		gameforge.locale.monster_chat_20016_2,
		gameforge.locale.monster_chat_20016_3,
		gameforge.locale.monster_chat_20016_4,
		gameforge.locale.monster_chat_20016_5
	},
	[20017] = {
		gameforge.locale.monster_chat_20017_1,
		gameforge.locale.monster_chat_20017_2,
		gameforge.locale.monster_chat_20017_3,
		gameforge.locale.monster_chat_20017_4,
		gameforge.locale.monster_chat_20017_5
	},
	[20018] = {
		gameforge.locale.monster_chat_20018_1,
		gameforge.locale.monster_chat_20018_2,
		gameforge.locale.monster_chat_20018_3,
		gameforge.locale.monster_chat_20018_4,
		gameforge.locale.monster_chat_20018_5
	},
	[20019] = {
		gameforge.locale.monster_chat_20019_1,
		gameforge.locale.monster_chat_20019_2,
		gameforge.locale.monster_chat_20019_3,
		gameforge.locale.monster_chat_20019_4,
		gameforge.locale.monster_chat_20019_5
	},
	[20020] = {
		gameforge.locale.monster_chat_20020_1,
		gameforge.locale.monster_chat_20020_2,
		gameforge.locale.monster_chat_20020_3,
		gameforge.locale.monster_chat_20020_4,
		gameforge.locale.monster_chat_20020_5
	},
	[20021] = {
		gameforge.locale.monster_chat_20021_1,
		gameforge.locale.monster_chat_20021_2,
		gameforge.locale.monster_chat_20021_3,
		gameforge.locale.monster_chat_20021_4,
		gameforge.locale.monster_chat_20021_5
	},
	[20022] = {
		gameforge.locale.monster_chat_20022_1,
		gameforge.locale.monster_chat_20022_2,
		gameforge.locale.monster_chat_20022_3,
		gameforge.locale.monster_chat_20022_4,
		gameforge.locale.monster_chat_20022_5
	},
	[20023] = {
		gameforge.locale.monster_chat_20023_1,
		gameforge.locale.monster_chat_20023_2,
		gameforge.locale.monster_chat_20023_3,
		gameforge.locale.monster_chat_20023_4,
		gameforge.locale.monster_chat_20023_5
	},
	[20024] = {
		gameforge.locale.monster_chat_20024_1,
		gameforge.locale.monster_chat_20024_2,
		gameforge.locale.monster_chat_20024_3,
		gameforge.locale.monster_chat_20024_4,
		gameforge.locale.monster_chat_20024_5
	},
	[11000] = {
		gameforge.locale.monster_chat_11000_1,
		gameforge.locale.monster_chat_11000_2,
		gameforge.locale.monster_chat_11000_3,
		gameforge.locale.monster_chat_11000_4,
		gameforge.locale.monster_chat_11000_5,
		gameforge.locale.monster_chat_11000_6,
		gameforge.locale.monster_chat_11000_7,
		gameforge.locale.monster_chat_11000_8,
		gameforge.locale.monster_chat_11000_9,
		gameforge.locale.monster_chat_11000_10,
		gameforge.locale.monster_chat_11000_11,
		gameforge.locale.monster_chat_11000_12,
		gameforge.locale.monster_chat_11000_13,
		gameforge.locale.monster_chat_11000_14,
		gameforge.locale.monster_chat_11000_15,
		gameforge.locale.monster_chat_11000_16,
		gameforge.locale.monster_chat_11000_17,
		gameforge.locale.monster_chat_11000_18,
		gameforge.locale.monster_chat_11000_19,
		gameforge.locale.monster_chat_11000_20,
		gameforge.locale.monster_chat_11000_21,
		gameforge.locale.monster_chat_11000_22,
		gameforge.locale.monster_chat_11000_23,
		gameforge.locale.monster_chat_11000_24,
		gameforge.locale.monster_chat_11000_25,
		gameforge.locale.monster_chat_11000_26,
		gameforge.locale.monster_chat_11000_27,
		gameforge.locale.monster_chat_11000_28,
		gameforge.locale.monster_chat_11000_29,
		gameforge.locale.monster_chat_11000_30,
		gameforge.locale.monster_chat_11000_31
	},
	[11002] = {
		gameforge.locale.monster_chat_11002_1,
		gameforge.locale.monster_chat_11002_2,
		gameforge.locale.monster_chat_11002_3,
		gameforge.locale.monster_chat_11002_4,
		gameforge.locale.monster_chat_11002_5,
		gameforge.locale.monster_chat_11002_6,
		gameforge.locale.monster_chat_11002_7,
		gameforge.locale.monster_chat_11002_8,
		gameforge.locale.monster_chat_11002_9,
		gameforge.locale.monster_chat_11002_10,
		gameforge.locale.monster_chat_11002_11,
		gameforge.locale.monster_chat_11002_12,
		gameforge.locale.monster_chat_11002_13,
		gameforge.locale.monster_chat_11002_14,
		gameforge.locale.monster_chat_11002_15,
		gameforge.locale.monster_chat_11002_16,
		gameforge.locale.monster_chat_11002_17,
		gameforge.locale.monster_chat_11002_18,
		gameforge.locale.monster_chat_11002_19,
		gameforge.locale.monster_chat_11002_20,
		gameforge.locale.monster_chat_11002_21,
		gameforge.locale.monster_chat_11002_22,
		gameforge.locale.monster_chat_11002_23,
		gameforge.locale.monster_chat_11002_24,
		gameforge.locale.monster_chat_11002_25,
		gameforge.locale.monster_chat_11002_26,
		gameforge.locale.monster_chat_11002_27,
		gameforge.locale.monster_chat_11002_28,
		gameforge.locale.monster_chat_11002_29,
		gameforge.locale.monster_chat_11002_30,
		gameforge.locale.monster_chat_11002_31
	},
	[11004] = {
		gameforge.locale.monster_chat_11004_1,
		gameforge.locale.monster_chat_11004_2,
		gameforge.locale.monster_chat_11004_3,
		gameforge.locale.monster_chat_11004_4,
		gameforge.locale.monster_chat_11004_5,
		gameforge.locale.monster_chat_11004_6,
		gameforge.locale.monster_chat_11004_7,
		gameforge.locale.monster_chat_11004_8,
		gameforge.locale.monster_chat_11004_9,
		gameforge.locale.monster_chat_11004_10,
		gameforge.locale.monster_chat_11004_11,
		gameforge.locale.monster_chat_11004_12,
		gameforge.locale.monster_chat_11004_13,
		gameforge.locale.monster_chat_11004_14,
		gameforge.locale.monster_chat_11004_15,
		gameforge.locale.monster_chat_11004_16,
		gameforge.locale.monster_chat_11004_17,
		gameforge.locale.monster_chat_11004_18,
		gameforge.locale.monster_chat_11004_19,
		gameforge.locale.monster_chat_11004_20,
		gameforge.locale.monster_chat_11004_21,
		gameforge.locale.monster_chat_11004_22,
		gameforge.locale.monster_chat_11004_23,
		gameforge.locale.monster_chat_11004_24,
		gameforge.locale.monster_chat_11004_25,
		gameforge.locale.monster_chat_11004_26,
		gameforge.locale.monster_chat_11004_27,
		gameforge.locale.monster_chat_11004_28,
		gameforge.locale.monster_chat_11004_29,
		gameforge.locale.monster_chat_11004_30,
		gameforge.locale.monster_chat_11004_31
	},
}

special.questscroll = {
	{ 
		QUEST_SCROLL_TYPE_KILL_MOB, 
		gameforge.locale.questscroll_1_text,
		gameforge.locale.questscroll_1_mis,
		gameforge.locale.questscroll_1_hunt,
		25,
	},
	{ 
		QUEST_SCROLL_TYPE_KILL_MOB, 
		gameforge.locale.questscroll_2_text,
		gameforge.locale.questscroll_2_mis,
		gameforge.locale.questscroll_2_hunt,
		20,
	},
	{ 
		QUEST_SCROLL_TYPE_KILL_MOB, 
		gameforge.locale.questscroll_3_text,
		gameforge.locale.questscroll_3_mis,
		gameforge.locale.questscroll_3_hunt,
		1,
	},
	{ 
		QUEST_SCROLL_TYPE_KILL_MOB, 
		gameforge.locale.questscroll_4_text,
		gameforge.locale.questscroll_4_mis,
		gameforge.locale.questscroll_4_hunt,
		1,
	},
	{ 
		QUEST_SCROLL_TYPE_KILL_MOB, 
		gameforge.locale.questscroll_5_text,
		gameforge.locale.questscroll_5_mis,
		gameforge.locale.questscroll_5_hunt,
		1,
	},
	{ 
		QUEST_SCROLL_TYPE_KILL_MOB, 
		gameforge.locale.questscroll_6_text,
		gameforge.locale.questscroll_6_mis,
		gameforge.locale.questscroll_6_hunt,
		1,
	},
	{ 
		QUEST_SCROLL_TYPE_KILL_MOB, 
		gameforge.locale.questscroll_7_text,
		gameforge.locale.questscroll_7_mis,
		gameforge.locale.questscroll_7_hunt,
		20,
	},
	{ 
		QUEST_SCROLL_TYPE_KILL_MOB, 
		gameforge.locale.questscroll_8_text,
		gameforge.locale.questscroll_8_mis,
		gameforge.locale.questscroll_8_hunt,
		20,
	},
	{ 
		QUEST_SCROLL_TYPE_KILL_MOB, 
		gameforge.locale.questscroll_9_text,
		gameforge.locale.questscroll_9_mis,
		gameforge.locale.questscroll_9_hunt,
		25,
	},
	{ 
		QUEST_SCROLL_TYPE_KILL_MOB, 
		gameforge.locale.questscroll_10_text,
		gameforge.locale.questscroll_10_mis,
		gameforge.locale.questscroll_10_hunt,
		20,
	},
	{ 
		QUEST_SCROLL_TYPE_KILL_MOB, 
		gameforge.locale.questscroll_11_text,
		gameforge.locale.questscroll_11_mis,
		gameforge.locale.questscroll_11_hunt,
		20,
	},
	{ 
		QUEST_SCROLL_TYPE_KILL_MOB, 
		gameforge.locale.questscroll_12_text,
		gameforge.locale.questscroll_12_mis,
		gameforge.locale.questscroll_12_hunt,
		12,
	},
	{ 
		QUEST_SCROLL_TYPE_KILL_MOB, 
		gameforge.locale.questscroll_13_text,
		gameforge.locale.questscroll_13_mis,
		gameforge.locale.questscroll_13_hunt,
		20,
	},
	{ 
		QUEST_SCROLL_TYPE_KILL_MOB, 
		gameforge.locale.questscroll_14_text,
		gameforge.locale.questscroll_14_mis,
		gameforge.locale.questscroll_14_hunt,
		20,
	},
	{ 
		QUEST_SCROLL_TYPE_KILL_MOB, 
		gameforge.locale.questscroll_15_text,
		gameforge.locale.questscroll_15_mis,
		gameforge.locale.questscroll_15_hunt,
		13,
	},
	{ 
		QUEST_SCROLL_TYPE_KILL_MOB, 
		gameforge.locale.questscroll_16_text,
		gameforge.locale.questscroll_16_mis,
		gameforge.locale.questscroll_16_hunt,
		25,
	},
	{ 
		QUEST_SCROLL_TYPE_KILL_MOB, 
		gameforge.locale.questscroll_17_text,
		gameforge.locale.questscroll_17_mis,
		gameforge.locale.questscroll_17_hunt,
		20,
	},
	{ 
		QUEST_SCROLL_TYPE_KILL_MOB, 
		gameforge.locale.questscroll_18_text,
		gameforge.locale.questscroll_18_mis,
		gameforge.locale.questscroll_18_hunt,
		25,
	},
	{ 
		QUEST_SCROLL_TYPE_KILL_MOB, 
		gameforge.locale.questscroll_19_text,
		gameforge.locale.questscroll_19_mis,
		gameforge.locale.questscroll_19_hunt,
		25,
	},	
	{ 
		QUEST_SCROLL_TYPE_KILL_ANOTHER_EMPIRE, 
		gameforge.locale.questscroll_20_text,
		gameforge.locale.questscroll_20_mis,
		gameforge.locale.questscroll_20_hunt,
		4,
	},
}

locale.questscroll = {}
locale.questscroll.exist = gameforge.locale.questscroll.exist
locale.questscroll.finish = gameforge.locale.questscroll.finish
locale.questscroll.finish_button = gameforge.locale.questscroll.finish_button

locale.remove_polymorph_chat = gameforge.locale.remove_polymorph_chat
locale.remove_polymorph_msg = gameforge.locale.remove_polymorph_msg

locale.fortune_words = {
	{
		gameforge.locale.fortune_words_1_title,
		gameforge.locale.fortune_words_1_body
	},
	{
		gameforge.locale.fortune_words_2_title,
		gameforge.locale.fortune_words_2_body
	},
	{
		gameforge.locale.fortune_words_3_title,
		gameforge.locale.fortune_words_3_body
	},
	{
		gameforge.locale.fortune_words_4_title,
		gameforge.locale.fortune_words_4_body
	},
	{
		gameforge.locale.fortune_words_5_title,
		gameforge.locale.fortune_words_5_body
	},
	{
		gameforge.locale.fortune_words_6_title,
		gameforge.locale.fortune_words_6_body
	},
	{
		gameforge.locale.fortune_words_7_title,
		gameforge.locale.fortune_words_7_body
	},
}

locale.christmas_tree = {}
locale.christmas_tree.greet = gameforge.locale.christmas_tree.greet
locale.christmas_tree.sel_put_sock = gameforge.locale.christmas_tree.sel_put_sock
locale.christmas_tree.sel_no_need = gameforge.locale.christmas_tree.sel_no_need
locale.christmas_tree.sel_intro_event = gameforge.locale.christmas_tree.sel_intro_event
locale.christmas_tree.no_more_sock = gameforge.locale.christmas_tree.no_more_sock
locale.christmas_tree.gain_item_msg = gameforge.locale.christmas_tree.gain_item_msg
locale.christmas_tree.no_sock = gameforge.locale.christmas_tree.no_sock
locale.christmas_tree.not_sock_time = gameforge.locale.christmas_tree.not_sock_time
locale.christmas_tree.greet2 = gameforge.locale.christmas_tree.greet2
locale.christmas_tree.intro_msg = gameforge.locale.christmas_tree.intro_msg
locale.christmas_tree.under_level_10 = gameforge.locale.christmas_tree.under_level_10
locale.christmas_tree.christmas_say_title = gameforge.locale.christmas_tree.christmas_say_title

locale.christmas_santa = {}
locale.christmas_santa.intro_msg = gameforge.locale.christmas_santa.intro_msg
locale.christmas_santa.skill_book_buy_cost = 10000
locale.christmas_santa.skill_book_msg = locale.christmas_santa.skill_book_buy_cost .. gameforge.locale.christmas_santa.skill_book_msg
locale.christmas_santa.skill_book_sold_out_msg = gameforge.locale.christmas_santa.skill_book_sold_out_msg
locale.christmas_santa.hairdye_buy_cost = 10000
locale.christmas_santa.hairdye_msg = locale.christmas_santa.hairdye_buy_cost .. gameforge.locale.christmas_santa.hairdye_msg
locale.christmas_santa.hairdye_sold_out_msg = gameforge.locale.christmas_santa.hairdye_sold_out_msg
locale.christmas_santa.not_enough_money = gameforge.locale.christmas_santa.want_skillbook
locale.christmas_santa.want_skillbook = gameforge.locale.christmas_santa.want_skillbook
locale.christmas_santa.want_hairdye = gameforge.locale.christmas_santa.want_hairdye
locale.christmas_santa.no_need = gameforge.locale.christmas_santa.no_need
locale.christmas_santa.bye_msg = gameforge.locale.christmas_santa.bye_msg
locale.christmas_santa.select_buy = gameforge.locale.christmas_santa.select_buy
locale.christmas_santa.select_stop = gameforge.locale.christmas_santa.select_stop

locale.years_greetings = {}
locale.years_greetings.chat_greet = gameforge.locale.years_greetings.chat_greet
locale.years_greetings.greet_msg = gameforge.locale.years_greetings.greet_msg
locale.years_greetings.select_1 = gameforge.locale.years_greetings.select_1
locale.years_greetings.select_2 = gameforge.locale.years_greetings.select_2
locale.years_greetings.select_3 = gameforge.locale.years_greetings.select_3
locale.years_greetings.under_level_15 = gameforge.locale.years_greetings.under_level_15
locale.years_greetings.give_msg = gameforge.locale.years_greetings.give_msg
locale.years_greetings.not_enoguh_inventory = gameforge.locale.years_greetings.not_enoguh_inventory
locale.years_greetings.no_money_this_time = gameforge.locale.years_greetings.no_money_this_time
locale.years_greetings.bless_msg = gameforge.locale.years_greetings.bless_msg
locale.years_greetings.event_info = gameforge.locale.years_greetings.event_info 

locale.make_wonso = {}
locale.make_wonso.want_wonso1 = gameforge.locale.make_wonso.want_wonso1
locale.make_wonso.how_make = gameforge.locale.make_wonso.how_make
locale.make_wonso.how_make_detail = gameforge.locale.make_wonso.how_make_detail
locale.make_wonso.make_msg1 = gameforge.locale.make_wonso.make_msg1
locale.make_wonso.make_msg2 = gameforge.locale.make_wonso.make_msg2
locale.make_wonso.make_msg3 = gameforge.locale.make_wonso.make_msg3

locale.horse_menu = {}
locale.horse_menu.menu = gameforge.locale.horse_menu.menu
locale.horse_menu.show_state = gameforge.locale.horse_menu.show_state
locale.horse_menu.revive = gameforge.locale.horse_menu.revive
locale.horse_menu.feed = gameforge.locale.horse_menu.feed
locale.horse_menu.ride = gameforge.locale.horse_menu.ride
locale.horse_menu.unsummon = gameforge.locale.horse_menu.unsummon
locale.horse_menu.close = gameforge.locale.horse_menu.close

locale.monkey_dungeon = {}
locale.monkey_dungeon.button = gameforge.locale.monkey_dungeon.button
locale.monkey_dungeon.curse_of_monkey_button = gameforge.locale.monkey_dungeon.curse_of_monkey_button
locale.monkey_dungeon.curse_of_monkey = gameforge.locale.monkey_dungeon.curse_of_monkey
locale.monkey_dungeon.cannot_ENTER_yet = gameforge.locale.monkey_dungeon.cannot_ENTER_yet
locale.monkey_dungeon.low_entrance = gameforge.locale.monkey_dungeon.low_entrance
locale.monkey_dungeon.middle_entrance = gameforge.locale.monkey_dungeon.middle_entrance
locale.monkey_dungeon.notice = gameforge.locale.monkey_dungeon.notice
locale.monkey_dungeon.quest_title = gameforge.locale.monkey_dungeon.quest_title
locale.monkey_dungeon.quest_rest_time = gameforge.locale.monkey_dungeon.quest_rest_time
locale.monkey_dungeon.ENTER = gameforge.locale.monkey_dungeon.ENTER
locale.monkey_dungeon.no_ENTER = gameforge.locale.monkey_dungeon.no_ENTER

locale.questscroll5 = {}
locale.questscroll5.mission = {
	{
		QUEST_SCROLL_TYPE_KILL_MOB,
		"Aa",
		gameforge.locale.questscroll5.mission_1_hunt,
		gameforge.locale.questscroll5.mission_1_text,
		gameforge.locale.questscroll5.mission_1_mis,
		"8002",
		3
	},
	{
		QUEST_SCROLL_TYPE_KILL_MOB,
		"Aa",
		gameforge.locale.questscroll5.mission_2_hunt,
		gameforge.locale.questscroll5.mission_2_text,
		gameforge.locale.questscroll5.mission_2_mis,
		"8001",
		2
	},
	{
		QUEST_SCROLL_TYPE_KILL_MOB,
		"Aa",
		gameforge.locale.questscroll5.mission_3_hunt,
		gameforge.locale.questscroll5.mission_3_text,
		gameforge.locale.questscroll5.mission_3_mis,
		"107",
		30
	},
	{
		QUEST_SCROLL_TYPE_KILL_MOB,
		"Aa",
		gameforge.locale.questscroll5.mission_4_hunt,
		gameforge.locale.questscroll5.mission_4_text,
		gameforge.locale.questscroll5.mission_4_mis,
		"106",
		35
	},
	{
		QUEST_SCROLL_TYPE_KILL_MOB,
		"Aa",
		gameforge.locale.questscroll5.mission_5_hunt,
		gameforge.locale.questscroll5.mission_5_text,
		gameforge.locale.questscroll5.mission_5_mis,
		"108",
		40
	},
	{
		QUEST_SCROLL_TYPE_KILL_MOB2,
		"Aa",
		gameforge.locale.questscroll5.mission_6_hunt,
		gameforge.locale.questscroll5.mission_6_text,
		gameforge.locale.questscroll5.mission_6_mis,
		"114"	,
		25,
		"110",
		30
	},
	{
		QUEST_SCROLL_TYPE_KILL_MOB,
		"Ab",
		gameforge.locale.questscroll5.mission_7_hunt,
		gameforge.locale.questscroll5.mission_7_text,
		gameforge.locale.questscroll5.mission_7_mis,
		"8004",
		2
	},
	{
		QUEST_SCROLL_TYPE_KILL_MOB,
		"Ab",
		gameforge.locale.questscroll5.mission_8_hunt,
		gameforge.locale.questscroll5.mission_8_text,
		gameforge.locale.questscroll5.mission_8_mis,
		"8003",
		2
	},
	{
		QUEST_SCROLL_TYPE_KILL_MOB,
		"Ab",
		gameforge.locale.questscroll5.mission_9_hunt,
		gameforge.locale.questscroll5.mission_9_text,
		gameforge.locale.questscroll5.mission_9_mis,
		"109",
		30
	},
	{
		QUEST_SCROLL_TYPE_KILL_MOB2,
		"Ab",
		gameforge.locale.questscroll5.mission_10_hunt,
		gameforge.locale.questscroll5.mission_10_text,
		gameforge.locale.questscroll5.mission_10_mis,
		"111",
		25,
		"112",
		25
	},
	{
		QUEST_SCROLL_TYPE_KILL_MOB2,
		"Ab",
		gameforge.locale.questscroll5.mission_11_hunt,
		gameforge.locale.questscroll5.mission_11_text,
		gameforge.locale.questscroll5.mission_11_mis,
		"104",
		35,
		"105",
		25
	},
	{
		QUEST_SCROLL_TYPE_KILL_MOB,
		"Ba",
		gameforge.locale.questscroll5.mission_12_hunt,
		gameforge.locale.questscroll5.mission_12_text,
		gameforge.locale.questscroll5.mission_12_mis,
		"304",
		20
	},
	{
		QUEST_SCROLL_TYPE_KILL_MOB2,
		"Ba",
		gameforge.locale.questscroll5.mission_13_hunt,
		gameforge.locale.questscroll5.mission_13_text,
		gameforge.locale.questscroll5.mission_13_mis,
		"404",
		25,
		"405",
		25
	},
	{
		QUEST_SCROLL_TYPE_KILL_MOB2,
		"Ba",
		gameforge.locale.questscroll5.mission_14_hunt,
		gameforge.locale.questscroll5.mission_14_text,
		gameforge.locale.questscroll5.mission_14_mis,
		"631",
		30,
		"632",
		30
	},
	{
		QUEST_SCROLL_TYPE_KILL_MOB2,
		"Ba",
		gameforge.locale.questscroll5.mission_15_hunt,
		gameforge.locale.questscroll5.mission_15_text,
		gameforge.locale.questscroll5.mission_15_mis,
		"501",
		30,
		"502",
		30
	},
	{
		QUEST_SCROLL_TYPE_KILL_MOB,
		"Bb",
		gameforge.locale.questscroll5.mission_16_hunt,
		gameforge.locale.questscroll5.mission_16_text,
		gameforge.locale.questscroll5.mission_16_mis,
		"8006",
		3
	},
	{
		QUEST_SCROLL_TYPE_KILL_MOB,
		"Bb",
		gameforge.locale.questscroll5.mission_17_hunt,
		gameforge.locale.questscroll5.mission_17_text,
		gameforge.locale.questscroll5.mission_17_mis,
		"8005",
		2
	},
	{
		QUEST_SCROLL_TYPE_KILL_MOB,
		"Bb",
		gameforge.locale.questscroll5.mission_18_hunt,
		gameforge.locale.questscroll5.mission_18_text,
		gameforge.locale.questscroll5.mission_18_mis,
		"393",
		10
	},
	{
		QUEST_SCROLL_TYPE_KILL_MOB2,
		"Bb",
		gameforge.locale.questscroll5.mission_19_hunt,
		gameforge.locale.questscroll5.mission_19_text,
		gameforge.locale.questscroll5.mission_19_mis,
		"633",
		20,
		"634",
		15
	},
	{
		QUEST_SCROLL_TYPE_KILL_MOB2,
		"Bb",
		gameforge.locale.questscroll5.mission_20_hunt,
		gameforge.locale.questscroll5.mission_20_text,
		gameforge.locale.questscroll5.mission_20_mis,
		"5111",
		30,
		"5112",
		30
	},
	{
		QUEST_SCROLL_TYPE_KILL_MOB2,
		"Bb",
		gameforge.locale.questscroll5.mission_21_hunt,
		gameforge.locale.questscroll5.mission_21_text,
		gameforge.locale.questscroll5.mission_21_mis,
		"5101",
		30,
		"5102",
		30
	},
	{
		QUEST_SCROLL_TYPE_KILL_MOB,
		"Bc",
		gameforge.locale.questscroll5.mission_22_hunt,
		gameforge.locale.questscroll5.mission_22_text,
		gameforge.locale.questscroll5.mission_22_mis,
		"494",
		4
	},
	{
		QUEST_SCROLL_TYPE_KILL_MOB,
		"Bc",
		gameforge.locale.questscroll5.mission_23_hunt,
		gameforge.locale.questscroll5.mission_23_text,
		gameforge.locale.questscroll5.mission_23_mis,
		"8007",
		2
	},
	{
		QUEST_SCROLL_TYPE_KILL_MOB2,
		"Bc",
		gameforge.locale.questscroll5.mission_24_hunt,
		gameforge.locale.questscroll5.mission_24_text,
		gameforge.locale.questscroll5.mission_24_mis,
		"5113",
		15,
		"5114",
		15
	},
	{
		QUEST_SCROLL_TYPE_KILL_MOB2,
		"Bc",
		gameforge.locale.questscroll5.mission_25_hunt,
		gameforge.locale.questscroll5.mission_25_text,
		gameforge.locale.questscroll5.mission_25_mis,
		"5103",
		15,
		"5104",
		15
	},
	{
		QUEST_SCROLL_TYPE_KILL_MOB,
		"Ca",
		gameforge.locale.questscroll5.mission_26_hunt,
		gameforge.locale.questscroll5.mission_26_text,
		gameforge.locale.questscroll5.mission_26_mis,
		"8008",
		2
	},
	{
		QUEST_SCROLL_TYPE_KILL_MOB,
		"Ca",
		gameforge.locale.questscroll5.mission_27_hunt,
		gameforge.locale.questscroll5.mission_27_text,
		gameforge.locale.questscroll5.mission_27_mis,
		"2001",
		40
	},
	{
		QUEST_SCROLL_TYPE_KILL_MOB,
		"Ca",
		gameforge.locale.questscroll5.mission_28_hunt,
		gameforge.locale.questscroll5.mission_28_text,
		gameforge.locale.questscroll5.mission_28_mis,
		"2002",
		40
	},
	{
		QUEST_SCROLL_TYPE_KILL_MOB2,
		"Ca",
		gameforge.locale.questscroll5.mission_29_hunt,
		gameforge.locale.questscroll5.mission_29_text,
		gameforge.locale.questscroll5.mission_29_mis,
		"703",
		20,
		"704",
		25
	},
	{
		QUEST_SCROLL_TYPE_KILL_MOB2,
		"Ca",
		gameforge.locale.questscroll5.mission_30_hunt,
		gameforge.locale.questscroll5.mission_30_text,
		gameforge.locale.questscroll5.mission_30_mis,
		"701",
		30,
		"702",
		30
	},
	{
		QUEST_SCROLL_TYPE_KILL_MOB2,
		"Ca",
		gameforge.locale.questscroll5.mission_31_hunt,
		gameforge.locale.questscroll5.mission_31_text,
		gameforge.locale.questscroll5.mission_31_mis,
		"706",
		40,
		"707",
		40
	},
	{
		QUEST_SCROLL_TYPE_KILL_MOB,
		"Cb",
		gameforge.locale.questscroll5.mission_32_hunt,
		gameforge.locale.questscroll5.mission_32_text,
		gameforge.locale.questscroll5.mission_32_mis,
		"8009",
		2
	},
	{
		QUEST_SCROLL_TYPE_KILL_MOB2,
		"Cb",
		gameforge.locale.questscroll5.mission_33_hunt,
		gameforge.locale.questscroll5.mission_33_text,
		gameforge.locale.questscroll5.mission_33_mis,
		"2031",
		35,
		"2032",
		35
	},
	{
		QUEST_SCROLL_TYPE_KILL_MOB2,
		"Cb",
		gameforge.locale.questscroll5.mission_34_hunt,
		gameforge.locale.questscroll5.mission_34_text,
		gameforge.locale.questscroll5.mission_34_mis,
		"2031",
		35,
		"2032",
		35
	},
	{
		QUEST_SCROLL_TYPE_KILL_MOB2,
		"Cb",
		gameforge.locale.questscroll5.mission_35_hunt,
		gameforge.locale.questscroll5.mission_35_text,
		gameforge.locale.questscroll5.mission_35_mis,
		"2033",
		35,
		"2034",
		35
	},
	{
		QUEST_SCROLL_TYPE_KILL_MOB,
		"Cb",
		gameforge.locale.questscroll5.mission_36_hunt,
		gameforge.locale.questscroll5.mission_36_text,
		gameforge.locale.questscroll5.mission_36_mis,
		"2035",
		40
	},
	{
		QUEST_SCROLL_TYPE_KILL_MOB,
		"Cc",
		gameforge.locale.questscroll5.mission_37_hunt,
		gameforge.locale.questscroll5.mission_37_text,
		gameforge.locale.questscroll5.mission_37_mis,
		"8010",
		2
	},
	{
		QUEST_SCROLL_TYPE_KILL_MOB2,
		"Cc",
		gameforge.locale.questscroll5.mission_38_hunt,
		gameforge.locale.questscroll5.mission_38_text,
		gameforge.locale.questscroll5.mission_38_mis,
		"2103",
		30,
		"2104",
		20
	},
	{
		QUEST_SCROLL_TYPE_KILL_MOB2,
		"Cc",
		gameforge.locale.questscroll5.mission_39_hunt,
		gameforge.locale.questscroll5.mission_39_text,
		gameforge.locale.questscroll5.mission_39_mis,
		"1001",
		30,
		"1002",
		20
	},
	{
		QUEST_SCROLL_TYPE_KILL_MOB2,
		"Cc",
		gameforge.locale.questscroll5.mission_40_hunt,
		gameforge.locale.questscroll5.mission_40_text,
		gameforge.locale.questscroll5.mission_40_mis,
		"1003",
		30,
		"1004",
		25
	},
	{
		QUEST_SCROLL_TYPE_KILL_MOB2,
		"Cd",
		gameforge.locale.questscroll5.mission_41_hunt,
		gameforge.locale.questscroll5.mission_41_text,
		gameforge.locale.questscroll5.mission_41_mis,
		"5123",
		15,
		"5124",
		15
	},
	{
		QUEST_SCROLL_TYPE_KILL_MOB,
		"Cd",
		gameforge.locale.questscroll5.mission_42_hunt,
		gameforge.locale.questscroll5.mission_42_text,
		gameforge.locale.questscroll5.mission_42_mis,
		"1107",
		25
	},
	{
		QUEST_SCROLL_TYPE_KILL_MOB2,
		"Cd",
		gameforge.locale.questscroll5.mission_43_hunt,
		gameforge.locale.questscroll5.mission_43_text,
		gameforge.locale.questscroll5.mission_43_mis,
		"5121",
		30,
		"5122",
		30
	},
	{
		QUEST_SCROLL_TYPE_KILL_MOB,
		"Cd",
		gameforge.locale.questscroll5.mission_44_hunt,
		gameforge.locale.questscroll5.mission_44_text,
		gameforge.locale.questscroll5.mission_44_mis,
		"1305",
		30
	},
	{
		QUEST_SCROLL_TYPE_KILL_MOB2,
		"Cd",
		gameforge.locale.questscroll5.mission_45_hunt,
		gameforge.locale.questscroll5.mission_45_text,
		gameforge.locale.questscroll5.mission_45_mis,
		"1105",
		35,
		"1106",
		30
	},
	{
		QUEST_SCROLL_TYPE_KILL_MOB2,
		"Cd",
		gameforge.locale.questscroll5.mission_46_hunt,
		gameforge.locale.questscroll5.mission_46_text,
		gameforge.locale.questscroll5.mission_46_mis,
		"1301",
		45,
		"1302",
		35
	},
	{
		QUEST_SCROLL_TYPE_KILL_MOB,
		"Cd",
		gameforge.locale.questscroll5.mission_47_hunt,
		gameforge.locale.questscroll5.mission_47_text,
		gameforge.locale.questscroll5.mission_47_mis,
		"1101",
		45
	},
	{
		QUEST_SCROLL_TYPE_KILL_MOB,
		"Da",
		gameforge.locale.questscroll5.mission_48_hunt,
		gameforge.locale.questscroll5.mission_48_text,
		gameforge.locale.questscroll5.mission_48_mis,
		"1063",
		45
	},
	{
		QUEST_SCROLL_TYPE_KILL_MOB,
		"Da",
		gameforge.locale.questscroll5.mission_49_hunt,
		gameforge.locale.questscroll5.mission_49_text,
		gameforge.locale.questscroll5.mission_49_mis,
		"1064",
		60
	},
	{
		QUEST_SCROLL_TYPE_KILL_MOB,
		"Da",
		gameforge.locale.questscroll5.mission_50_hunt,
		gameforge.locale.questscroll5.mission_50_text,
		gameforge.locale.questscroll5.mission_50_mis,
		"2201",
		45
	},
	{
		QUEST_SCROLL_TYPE_KILL_MOB,
		"Db",
		gameforge.locale.questscroll5.mission_51_hunt,
		gameforge.locale.questscroll5.mission_51_text,
		gameforge.locale.questscroll5.mission_51_mis,
		"2202",
		45
	},
	{
		QUEST_SCROLL_TYPE_KILL_MOB2,
		"Db",
		gameforge.locale.questscroll5.mission_52_hunt,
		gameforge.locale.questscroll5.mission_52_text,
		gameforge.locale.questscroll5.mission_52_mis,
		"2201",
		60,
		"2203",
		40
	},
	{
		QUEST_SCROLL_TYPE_KILL_MOB,
		"Db",
		gameforge.locale.questscroll5.mission_53_hunt,
		gameforge.locale.questscroll5.mission_53_text,
		gameforge.locale.questscroll5.mission_53_mis,
		"2204",
		40
	},
	{
		QUEST_SCROLL_TYPE_KILL_MOB,
		"Db",
		gameforge.locale.questscroll5.mission_54_hunt,
		gameforge.locale.questscroll5.mission_54_text,
		gameforge.locale.questscroll5.mission_54_mis,
		"2205",
		60
	},
	{
		QUEST_SCROLL_TYPE_KILL_MOB,
		"Dc",
		gameforge.locale.questscroll5.mission_55_hunt,
		gameforge.locale.questscroll5.mission_55_text,
		gameforge.locale.questscroll5.mission_55_mis,
		"2301",
		30
	},
	{
		QUEST_SCROLL_TYPE_KILL_MOB2,
		"Dc",
		gameforge.locale.questscroll5.mission_56_hunt,
		gameforge.locale.questscroll5.mission_56_text,
		gameforge.locale.questscroll5.mission_56_mis,
		"2302",
		40,
		"2303",
		30
	},
}

locale.questscroll5.reward_exp = {
	["Aa"] = {
		{10000, 30},
		{20000, 40},
		{30000, 25},
		{50000,  3},
		{80000,  2},
	},
	["Ab"] = {
		{10000, 20},
		{20000, 30},
		{30000, 35},
		{50000, 10},
		{80000,  5},
	},
	["Ba"] = {
		{20000, 25},
		{30000, 35},
		{50000, 25},
		{80000, 10},
		{100000,  5},
	},
	["Bb"] = {
		{20000, 10},
		{30000, 25},
		{50000, 35},
		{80000, 20},
		{100000, 10},
	},
	["Bc"] = {
		{20000,  5},
		{30000, 15},
		{50000, 35},
		{80000, 30},
		{100000, 15},
	},
	["Ca"] = {
		{30000, 20},
		{50000, 40},
		{100000, 30},
		{150000,  8},
		{200000,  2},
	},
	["Cb"] = {
		{30000, 15},
		{50000, 30},
		{100000, 35},
		{150000, 10},
		{200000, 10},
	},
	["Cc"] = {
		{30000, 10},
		{50000, 15},
		{100000, 35},
		{150000, 25},
		{200000, 15},
	},
	["Cd"] = {
		{30000,  5},
		{50000, 10},
		{100000, 30},
		{150000, 35},
		{200000, 20},
	},
	["Da"] = {
		{30000, 20},
		{50000, 40},
		{100000, 30},
		{150000,  8},
		{200000,  2},
	},
	["Db"] = {
		{30000, 15},
		{50000, 30},
		{100000, 35},
		{150000, 10},
		{200000, 10},
	},
	["Dc"] = {
		{30000, 10},
		{50000, 15},
		{100000, 35},
		{150000, 25},
		{200000, 15},
	},
}
locale.questscroll5.reward_money = {
	["Aa"] = {
		{5000, 30},
		{10000, 40},
		{20000, 25},
		{50000, 3},
		{100000, 2},
	},
	["Ab"] = {
		{5000, 20},
		{10000, 30},
		{20000, 35},
		{50000, 10},
		{100000, 5},
	},
	["Ba"] = {
		{10000, 30},
		{30000, 40},
		{50000, 25},
		{80000, 3},
		{100000, 2},
	},
	["Bb"] = {
		{10000, 20},
		{30000, 30},
		{50000, 35},
		{80000, 10},
		{100000, 5},
	},
	["Bc"] = {
		{10000, 10},
		{30000, 20},
		{50000, 35},
		{80000, 30},
		{100000, 5},
	},
	["Ca"] = {
		{30000, 20},
		{50000, 40},
		{80000, 30},
		{100000, 8},
		{150000, 2},
	},
	["Cb"] = {
		{30000, 15},
		{50000, 30},
		{80000, 35},
		{100000, 10},
		{150000, 10},
	},
	["Cc"] = {
		{30000, 10},
		{50000, 15},
		{80000, 35},
		{100000, 25},
		{150000, 10},
	},
	["Cd"] = {
		{30000, 5},
		{50000, 10},
		{80000, 30},
		{100000, 35},
		{150000, 20},
	},
	["Da"] = {
		{30000, 20},
		{50000, 40},
		{80000, 30},
		{100000, 8},
		{150000, 2},
	},
	["Db"] = {
		{30000, 15},
		{50000, 30},
		{80000, 35},
		{100000, 10},
		{150000, 10},
	},
	["Dc"] = {
		{30000, 10},
		{50000, 15},
		{80000, 35},
		{100000, 25},
		{150000, 10},
	},
}
locale.questscroll5.reward_item = {
	["Aa"] = {
		{30053, 1},
		{30072, 1},
		{30071, 1},
		{30003, 1},
		{30023, 1},
		{30038, 1},
	},
	["Ab"] = {
		{30037, 1},
		{30010, 1},
		{30004, 1},
		{30028, 1},
		{30069, 1},
		{30027, 1},
		{30070, 1},
	},
	["Ba"] = {
		{30032, 1},
		{30034, 1},
		{30073, 1},
		{30035, 1},
		{30008, 1},
		{30005, 1},
		{30021, 1},
		{30033, 1},
		{30041, 1},
		{30092, 1},
	},
	["Bb"] = {
		{30074, 1},
		{30076, 1},
		{30056, 1},
		{30057, 1},
		{30006, 1},
		{30077, 1},
		{30030, 1},
		{30058, 1},
		{30025, 1},
		{30055, 1},
	},
	["Bc"] = {
		{30046, 1},
		{30045, 1},
		{30018, 1},
		{30007, 1},
		{30052, 1},
		{30081, 1},
		{30031, 1},
		{30017, 1},
		{30011, 1},
	},
	["Ca"] = {
		{30085, 1},
		{30088, 1},
		{30016, 1},
		{30061, 1},
		{30040, 1},
		{30091, 1},
		{30059, 1},
	},
	["Cb"] = {
		{30060, 1},
		{30039, 1},
		{30042, 1},
		{30009, 1},
		{30079, 1},
		{30075, 1},
		{30022, 1},
		{30087, 1},
	},
	["Cc"] = {
		{30015, 1},
		{30019, 1},
		{30014, 1},
		{30048, 1},
		{30078, 1},
		{30083, 1},
		{30086, 1},
		{30090, 1},
		{30089, 1},
	},
	["Cd"] = {
		{30049, 1},
		{30047, 1},
		{30067, 1},
		{30080, 1},
		{30051, 1},
		{30050, 1},
	},
	["Da"] = {
		{30045, 1},
		{30051, 1},
		{30038, 1},
		{30070, 1},
		{30023, 1},
		{30033, 1},
		{30011, 1},
		{30027, 1},
		{30082, 1},
	},
	["Db"] = {
		{30035, 1},
		{30010, 1},
		{30055, 1},
		{30006, 1},
		{30003, 1},
		{30017, 1},
		{30058, 1},
		{30086, 1},
	},
	["Dc"] = {
		{70048, 15},
		{70050, 15},
		{70051, 15},
		{70102, 5},
		{50513, 5},
		{50301, 20},
		{50302, 15},
		{50303, 10},
	},

}

locale.quiz = {
	{
		gameforge.locale.quiz_1_0_question,
		gameforge.locale.quiz_1_1_choice,
		gameforge.locale.quiz_1_2_choice,
		gameforge.locale.quiz_1_3_choice,
		gameforge.locale.quiz_1_4_choice,
		gameforge.locale.quiz_1_5_answer
	},
	{
		gameforge.locale.quiz_2_0_question,
		gameforge.locale.quiz_2_1_choice,
		gameforge.locale.quiz_2_2_choice,
		gameforge.locale.quiz_2_3_choice,
		gameforge.locale.quiz_2_4_choice,
		gameforge.locale.quiz_2_5_answer
	},
	{
		gameforge.locale.quiz_3_0_question,
		gameforge.locale.quiz_3_1_choice,
		gameforge.locale.quiz_3_2_choice,
		gameforge.locale.quiz_3_3_choice,
		gameforge.locale.quiz_3_4_choice,
		gameforge.locale.quiz_3_5_answer
	},
	{
		gameforge.locale.quiz_4_0_question,
		gameforge.locale.quiz_4_1_choice,
		gameforge.locale.quiz_4_2_choice,
		gameforge.locale.quiz_4_3_choice,
		gameforge.locale.quiz_4_4_choice,
		gameforge.locale.quiz_4_5_answer
	},
	{
		gameforge.locale.quiz_5_0_question,
		gameforge.locale.quiz_5_1_choice,
		gameforge.locale.quiz_5_2_choice,
		gameforge.locale.quiz_5_3_choice,
		gameforge.locale.quiz_5_4_choice,
		gameforge.locale.quiz_5_5_answer
	},
	{
		gameforge.locale.quiz_6_0_question,
		gameforge.locale.quiz_6_1_choice,
		gameforge.locale.quiz_6_2_choice,
		gameforge.locale.quiz_6_3_choice,
		gameforge.locale.quiz_6_4_choice,
		gameforge.locale.quiz_6_5_answer
	},
	{
		gameforge.locale.quiz_7_0_question,
		gameforge.locale.quiz_7_1_choice,
		gameforge.locale.quiz_7_2_choice,
		gameforge.locale.quiz_7_3_choice,
		gameforge.locale.quiz_7_4_choice,
		gameforge.locale.quiz_7_5_answer
	},
	{
		gameforge.locale.quiz_8_0_question,
		gameforge.locale.quiz_8_1_choice,
		gameforge.locale.quiz_8_2_choice,
		gameforge.locale.quiz_8_3_choice,
		gameforge.locale.quiz_8_4_choice,
		gameforge.locale.quiz_8_5_answer
	},
	{
		gameforge.locale.quiz_9_0_question,
		gameforge.locale.quiz_9_1_choice,
		gameforge.locale.quiz_9_2_choice,
		gameforge.locale.quiz_9_3_choice,
		gameforge.locale.quiz_9_4_choice,
		gameforge.locale.quiz_9_5_answer
	},
	{
		gameforge.locale.quiz_10_0_question,
		gameforge.locale.quiz_10_1_choice,
		gameforge.locale.quiz_10_2_choice,
		gameforge.locale.quiz_10_3_choice,
		gameforge.locale.quiz_10_4_choice,
		gameforge.locale.quiz_10_5_answer
	},
	{
		gameforge.locale.quiz_11_0_question,
		gameforge.locale.quiz_11_1_choice,
		gameforge.locale.quiz_11_2_choice,
		gameforge.locale.quiz_11_3_choice,
		gameforge.locale.quiz_11_4_choice,
		gameforge.locale.quiz_11_5_answer
	},
	{
		gameforge.locale.quiz_12_0_question,
		gameforge.locale.quiz_12_1_choice,
		gameforge.locale.quiz_12_2_choice,
		gameforge.locale.quiz_12_3_choice,
		gameforge.locale.quiz_12_4_choice,
		gameforge.locale.quiz_12_5_answer
	},
	{
		gameforge.locale.quiz_13_0_question,
		gameforge.locale.quiz_13_1_choice,
		gameforge.locale.quiz_13_2_choice,
		gameforge.locale.quiz_13_3_choice,
		gameforge.locale.quiz_13_4_choice,
		gameforge.locale.quiz_13_5_answer
	},
	{
		gameforge.locale.quiz_14_0_question,
		gameforge.locale.quiz_14_1_choice,
		gameforge.locale.quiz_14_2_choice,
		gameforge.locale.quiz_14_3_choice,
		gameforge.locale.quiz_14_4_choice,
		gameforge.locale.quiz_14_5_answer
	},
	{
		gameforge.locale.quiz_15_0_question,
		gameforge.locale.quiz_15_1_choice,
		gameforge.locale.quiz_15_2_choice,
		gameforge.locale.quiz_15_3_choice,
		gameforge.locale.quiz_15_4_choice,
		gameforge.locale.quiz_15_5_answer
	},
	{
		gameforge.locale.quiz_16_0_question,
		gameforge.locale.quiz_16_1_choice,
		gameforge.locale.quiz_16_2_choice,
		gameforge.locale.quiz_16_3_choice,
		gameforge.locale.quiz_16_4_choice,
		gameforge.locale.quiz_16_5_answer
	},
	{
		gameforge.locale.quiz_17_0_question,
		gameforge.locale.quiz_17_1_choice,
		gameforge.locale.quiz_17_2_choice,
		gameforge.locale.quiz_17_3_choice,
		gameforge.locale.quiz_17_4_choice,
		gameforge.locale.quiz_17_5_answer
	},
	{
		gameforge.locale.quiz_18_0_question,
		gameforge.locale.quiz_18_1_choice,
		gameforge.locale.quiz_18_2_choice,
		gameforge.locale.quiz_18_3_choice,
		gameforge.locale.quiz_18_4_choice,
		gameforge.locale.quiz_18_5_answer
	},
	{
		gameforge.locale.quiz_19_0_question,
		gameforge.locale.quiz_19_1_choice,
		gameforge.locale.quiz_19_2_choice,
		gameforge.locale.quiz_19_3_choice,
		gameforge.locale.quiz_19_4_choice,
		gameforge.locale.quiz_19_5_answer
	},
	{
		gameforge.locale.quiz_20_0_question,
		gameforge.locale.quiz_20_1_choice,
		gameforge.locale.quiz_20_2_choice,
		gameforge.locale.quiz_20_3_choice,
		gameforge.locale.quiz_20_4_choice,
		gameforge.locale.quiz_20_5_answer
	},
	{
		gameforge.locale.quiz_21_0_question,
		gameforge.locale.quiz_21_1_choice,
		gameforge.locale.quiz_21_2_choice,
		gameforge.locale.quiz_21_3_choice,
		gameforge.locale.quiz_21_4_choice,
		gameforge.locale.quiz_21_5_answer
	},
	{
		gameforge.locale.quiz_22_0_question,
		gameforge.locale.quiz_22_1_choice,
		gameforge.locale.quiz_22_2_choice,
		gameforge.locale.quiz_22_3_choice,
		gameforge.locale.quiz_22_4_choice,
		gameforge.locale.quiz_22_5_answer
	},
	{
		gameforge.locale.quiz_23_0_question,
		gameforge.locale.quiz_23_1_choice,
		gameforge.locale.quiz_23_2_choice,
		gameforge.locale.quiz_23_3_choice,
		gameforge.locale.quiz_23_4_choice,
		gameforge.locale.quiz_23_5_answer
	},
	{
		gameforge.locale.quiz_24_0_question,
		gameforge.locale.quiz_24_1_choice,
		gameforge.locale.quiz_24_2_choice,
		gameforge.locale.quiz_24_3_choice,
		gameforge.locale.quiz_24_4_choice,
		gameforge.locale.quiz_24_5_answer
	},
	{
		gameforge.locale.quiz_25_0_question,
		gameforge.locale.quiz_25_1_choice,
		gameforge.locale.quiz_25_2_choice,
		gameforge.locale.quiz_25_3_choice,
		gameforge.locale.quiz_25_4_choice,
		gameforge.locale.quiz_25_5_answer
	},
	{
		gameforge.locale.quiz_26_0_question,
		gameforge.locale.quiz_26_1_choice,
		gameforge.locale.quiz_26_2_choice,
		gameforge.locale.quiz_26_3_choice,
		gameforge.locale.quiz_26_4_choice,
		gameforge.locale.quiz_26_5_answer
	},
	{
		gameforge.locale.quiz_27_0_question,
		gameforge.locale.quiz_27_1_choice,
		gameforge.locale.quiz_27_2_choice,
		gameforge.locale.quiz_27_3_choice,
		gameforge.locale.quiz_27_4_choice,
		gameforge.locale.quiz_27_5_answer
	},
	{
		gameforge.locale.quiz_28_0_question,
		gameforge.locale.quiz_28_1_choice,
		gameforge.locale.quiz_28_2_choice,
		gameforge.locale.quiz_28_3_choice,
		gameforge.locale.quiz_28_4_choice,
		gameforge.locale.quiz_28_5_answer
	},
	{
		gameforge.locale.quiz_29_0_question,
		gameforge.locale.quiz_29_1_choice,
		gameforge.locale.quiz_29_2_choice,
		gameforge.locale.quiz_29_3_choice,
		gameforge.locale.quiz_29_4_choice,
		gameforge.locale.quiz_29_5_answer
	},
	{
		gameforge.locale.quiz_30_0_question,
		gameforge.locale.quiz_30_1_choice,
		gameforge.locale.quiz_30_2_choice,
		gameforge.locale.quiz_30_3_choice,
		gameforge.locale.quiz_30_4_choice,
		gameforge.locale.quiz_30_5_answer
	},
	{
		gameforge.locale.quiz_31_0_question,
		gameforge.locale.quiz_31_1_choice,
		gameforge.locale.quiz_31_2_choice,
		gameforge.locale.quiz_31_3_choice,
		gameforge.locale.quiz_31_4_choice,
		gameforge.locale.quiz_31_5_answer
	},
	{
		gameforge.locale.quiz_32_0_question,
		gameforge.locale.quiz_32_1_choice,
		gameforge.locale.quiz_32_2_choice,
		gameforge.locale.quiz_32_3_choice,
		gameforge.locale.quiz_32_4_choice,
		gameforge.locale.quiz_32_5_answer
	},
	{
		gameforge.locale.quiz_33_0_question,
		gameforge.locale.quiz_33_1_choice,
		gameforge.locale.quiz_33_2_choice,
		gameforge.locale.quiz_33_3_choice,
		gameforge.locale.quiz_33_4_choice,
		gameforge.locale.quiz_33_5_answer
	},
	{
		gameforge.locale.quiz_34_0_question,
		gameforge.locale.quiz_34_1_choice,
		gameforge.locale.quiz_34_2_choice,
		gameforge.locale.quiz_34_3_choice,
		gameforge.locale.quiz_34_4_choice,
		gameforge.locale.quiz_34_5_answer
	},
	{
		gameforge.locale.quiz_35_0_question,
		gameforge.locale.quiz_35_1_choice,
		gameforge.locale.quiz_35_2_choice,
		gameforge.locale.quiz_35_3_choice,
		gameforge.locale.quiz_35_4_choice,
		gameforge.locale.quiz_35_5_answer
	},
	{
		gameforge.locale.quiz_36_0_question,
		gameforge.locale.quiz_36_1_choice,
		gameforge.locale.quiz_36_2_choice,
		gameforge.locale.quiz_36_3_choice,
		gameforge.locale.quiz_36_4_choice,
		gameforge.locale.quiz_36_5_answer
	},
	{
		gameforge.locale.quiz_37_0_question,
		gameforge.locale.quiz_37_1_choice,
		gameforge.locale.quiz_37_2_choice,
		gameforge.locale.quiz_37_3_choice,
		gameforge.locale.quiz_37_4_choice,
		gameforge.locale.quiz_37_5_answer
	},
	{
		gameforge.locale.quiz_38_0_question,
		gameforge.locale.quiz_38_1_choice,
		gameforge.locale.quiz_38_2_choice,
		gameforge.locale.quiz_38_3_choice,
		gameforge.locale.quiz_38_4_choice,
		gameforge.locale.quiz_38_5_answer
	},
	{
		gameforge.locale.quiz_39_0_question,
		gameforge.locale.quiz_39_1_choice,
		gameforge.locale.quiz_39_2_choice,
		gameforge.locale.quiz_39_3_choice,
		gameforge.locale.quiz_39_4_choice,
		gameforge.locale.quiz_39_5_answer
	},
	{
		gameforge.locale.quiz_40_0_question,
		gameforge.locale.quiz_40_1_choice,
		gameforge.locale.quiz_40_2_choice,
		gameforge.locale.quiz_40_3_choice,
		gameforge.locale.quiz_40_4_choice,
		gameforge.locale.quiz_40_5_answer
	},
	{
		gameforge.locale.quiz_41_0_question,
		gameforge.locale.quiz_41_1_choice,
		gameforge.locale.quiz_41_2_choice,
		gameforge.locale.quiz_41_3_choice,
		gameforge.locale.quiz_41_4_choice,
		gameforge.locale.quiz_41_5_answer
	},
	{
		gameforge.locale.quiz_42_0_question,
		gameforge.locale.quiz_42_1_choice,
		gameforge.locale.quiz_42_2_choice,
		gameforge.locale.quiz_42_3_choice,
		gameforge.locale.quiz_42_4_choice,
		gameforge.locale.quiz_42_5_answer
	},
	{
		gameforge.locale.quiz_43_0_question,
		gameforge.locale.quiz_43_1_choice,
		gameforge.locale.quiz_43_2_choice,
		gameforge.locale.quiz_43_3_choice,
		gameforge.locale.quiz_43_4_choice,
		gameforge.locale.quiz_43_5_answer
	},
	{
		gameforge.locale.quiz_44_0_question,
		gameforge.locale.quiz_44_1_choice,
		gameforge.locale.quiz_44_2_choice,
		gameforge.locale.quiz_44_3_choice,
		gameforge.locale.quiz_44_4_choice,
		gameforge.locale.quiz_44_5_answer
	},
	{
		gameforge.locale.quiz_45_0_question,
		gameforge.locale.quiz_45_1_choice,
		gameforge.locale.quiz_45_2_choice,
		gameforge.locale.quiz_45_3_choice,
		gameforge.locale.quiz_45_4_choice,
		gameforge.locale.quiz_45_5_answer
	},
	{
		gameforge.locale.quiz_46_0_question,
		gameforge.locale.quiz_46_1_choice,
		gameforge.locale.quiz_46_2_choice,
		gameforge.locale.quiz_46_3_choice,
		gameforge.locale.quiz_46_4_choice,
		gameforge.locale.quiz_46_5_answer
	},
	{
		gameforge.locale.quiz_47_0_question,
		gameforge.locale.quiz_47_1_choice,
		gameforge.locale.quiz_47_2_choice,
		gameforge.locale.quiz_47_3_choice,
		gameforge.locale.quiz_47_4_choice,
		gameforge.locale.quiz_47_5_answer
	},
	{
		gameforge.locale.quiz_48_0_question,
		gameforge.locale.quiz_48_1_choice,
		gameforge.locale.quiz_48_2_choice,
		gameforge.locale.quiz_48_3_choice,
		gameforge.locale.quiz_48_4_choice,
		gameforge.locale.quiz_48_5_answer
	},
	{
		gameforge.locale.quiz_49_0_question,
		gameforge.locale.quiz_49_1_choice,
		gameforge.locale.quiz_49_2_choice,
		gameforge.locale.quiz_49_3_choice,
		gameforge.locale.quiz_49_4_choice,
		gameforge.locale.quiz_49_5_answer
	},
	{
		gameforge.locale.quiz_50_0_question,
		gameforge.locale.quiz_50_1_choice,
		gameforge.locale.quiz_50_2_choice,
		gameforge.locale.quiz_50_3_choice,
		gameforge.locale.quiz_50_4_choice,
		gameforge.locale.quiz_50_5_answer
	},
	{
		gameforge.locale.quiz_51_0_question,
		gameforge.locale.quiz_51_1_choice,
		gameforge.locale.quiz_51_2_choice,
		gameforge.locale.quiz_51_3_choice,
		gameforge.locale.quiz_51_4_choice,
		gameforge.locale.quiz_51_5_answer
	},
	{
		gameforge.locale.quiz_52_0_question,
		gameforge.locale.quiz_52_1_choice,
		gameforge.locale.quiz_52_2_choice,
		gameforge.locale.quiz_52_3_choice,
		gameforge.locale.quiz_52_4_choice,
		gameforge.locale.quiz_52_5_answer
	},
	{
		gameforge.locale.quiz_53_0_question,
		gameforge.locale.quiz_53_1_choice,
		gameforge.locale.quiz_53_2_choice,
		gameforge.locale.quiz_53_3_choice,
		gameforge.locale.quiz_53_4_choice,
		gameforge.locale.quiz_53_5_answer
	},
	{
		gameforge.locale.quiz_54_0_question,
		gameforge.locale.quiz_54_1_choice,
		gameforge.locale.quiz_54_2_choice,
		gameforge.locale.quiz_54_3_choice,
		gameforge.locale.quiz_54_4_choice,
		gameforge.locale.quiz_54_5_answer
	},
	{
		gameforge.locale.quiz_55_0_question,
		gameforge.locale.quiz_55_1_choice,
		gameforge.locale.quiz_55_2_choice,
		gameforge.locale.quiz_55_3_choice,
		gameforge.locale.quiz_55_4_choice,
		gameforge.locale.quiz_55_5_answer
	},
	{
		gameforge.locale.quiz_56_0_question,
		gameforge.locale.quiz_56_1_choice,
		gameforge.locale.quiz_56_2_choice,
		gameforge.locale.quiz_56_3_choice,
		gameforge.locale.quiz_56_4_choice,
		gameforge.locale.quiz_56_5_answer
	},
	{
		gameforge.locale.quiz_57_0_question,
		gameforge.locale.quiz_57_1_choice,
		gameforge.locale.quiz_57_2_choice,
		gameforge.locale.quiz_57_3_choice,
		gameforge.locale.quiz_57_4_choice,
		gameforge.locale.quiz_57_5_answer
	},
	{
		gameforge.locale.quiz_58_0_question,
		gameforge.locale.quiz_58_1_choice,
		gameforge.locale.quiz_58_2_choice,
		gameforge.locale.quiz_58_3_choice,
		gameforge.locale.quiz_58_4_choice,
		gameforge.locale.quiz_58_5_answer
	},
	{
		gameforge.locale.quiz_59_0_question,
		gameforge.locale.quiz_59_1_choice,
		gameforge.locale.quiz_59_2_choice,
		gameforge.locale.quiz_59_3_choice,
		gameforge.locale.quiz_59_4_choice,
		gameforge.locale.quiz_59_5_answer
	},
	{
		gameforge.locale.quiz_60_0_question,
		gameforge.locale.quiz_60_1_choice,
		gameforge.locale.quiz_60_2_choice,
		gameforge.locale.quiz_60_3_choice,
		gameforge.locale.quiz_60_4_choice,
		gameforge.locale.quiz_60_5_answer
	},
	{
		gameforge.locale.quiz_61_0_question,
		gameforge.locale.quiz_61_1_choice,
		gameforge.locale.quiz_61_2_choice,
		gameforge.locale.quiz_61_3_choice,
		gameforge.locale.quiz_61_4_choice,
		gameforge.locale.quiz_61_5_answer
	},
	{
		gameforge.locale.quiz_62_0_question,
		gameforge.locale.quiz_62_1_choice,
		gameforge.locale.quiz_62_2_choice,
		gameforge.locale.quiz_62_3_choice,
		gameforge.locale.quiz_62_4_choice,
		gameforge.locale.quiz_62_5_answer
	},
	{
		gameforge.locale.quiz_63_0_question,
		gameforge.locale.quiz_63_1_choice,
		gameforge.locale.quiz_63_2_choice,
		gameforge.locale.quiz_63_3_choice,
		gameforge.locale.quiz_63_4_choice,
		gameforge.locale.quiz_63_5_answer
	},
	{
		gameforge.locale.quiz_64_0_question,
		gameforge.locale.quiz_64_1_choice,
		gameforge.locale.quiz_64_2_choice,
		gameforge.locale.quiz_64_3_choice,
		gameforge.locale.quiz_64_4_choice,
		gameforge.locale.quiz_64_5_answer
	},
	{
		gameforge.locale.quiz_65_0_question,
		gameforge.locale.quiz_65_1_choice,
		gameforge.locale.quiz_65_2_choice,
		gameforge.locale.quiz_65_3_choice,
		gameforge.locale.quiz_65_4_choice,
		gameforge.locale.quiz_65_5_answer
	},
	{
		gameforge.locale.quiz_66_0_question,
		gameforge.locale.quiz_66_1_choice,
		gameforge.locale.quiz_66_2_choice,
		gameforge.locale.quiz_66_3_choice,
		gameforge.locale.quiz_66_4_choice,
		gameforge.locale.quiz_66_5_answer
	},
	{
		gameforge.locale.quiz_67_0_question,
		gameforge.locale.quiz_67_1_choice,
		gameforge.locale.quiz_67_2_choice,
		gameforge.locale.quiz_67_3_choice,
		gameforge.locale.quiz_67_4_choice,
		gameforge.locale.quiz_67_5_answer
	},
	{
		gameforge.locale.quiz_68_0_question,
		gameforge.locale.quiz_68_1_choice,
		gameforge.locale.quiz_68_2_choice,
		gameforge.locale.quiz_68_3_choice,
		gameforge.locale.quiz_68_4_choice,
		gameforge.locale.quiz_68_5_answer
	},
	{
		gameforge.locale.quiz_69_0_question,
		gameforge.locale.quiz_69_1_choice,
		gameforge.locale.quiz_69_2_choice,
		gameforge.locale.quiz_69_3_choice,
		gameforge.locale.quiz_69_4_choice,
		gameforge.locale.quiz_69_5_answer
	},
	{
		gameforge.locale.quiz_70_0_question,
		gameforge.locale.quiz_70_1_choice,
		gameforge.locale.quiz_70_2_choice,
		gameforge.locale.quiz_70_3_choice,
		gameforge.locale.quiz_70_4_choice,
		gameforge.locale.quiz_70_5_answer
	},
	{
		gameforge.locale.quiz_71_0_question,
		gameforge.locale.quiz_71_1_choice,
		gameforge.locale.quiz_71_2_choice,
		gameforge.locale.quiz_71_3_choice,
		gameforge.locale.quiz_71_4_choice,
		gameforge.locale.quiz_71_5_answer
	},
}

locale.GM_SKILL_NAME_DICT = {
	[1] = gameforge.locale.gm_skill_name_1,
	[2] = gameforge.locale.gm_skill_name_2,
	[3] = gameforge.locale.gm_skill_name_3,
	[4] = gameforge.locale.gm_skill_name_4,
	[5] = gameforge.locale.gm_skill_name_5,
	[16] = gameforge.locale.gm_skill_name_6,
	[17] = gameforge.locale.gm_skill_name_7,
	[18] = gameforge.locale.gm_skill_name_8,
	[19] = gameforge.locale.gm_skill_name_9,
	[20] = gameforge.locale.gm_skill_name_10,
	[31] = gameforge.locale.gm_skill_name_11,
	[32] = gameforge.locale.gm_skill_name_12,
	[33] = gameforge.locale.gm_skill_name_13,
	[34] = gameforge.locale.gm_skill_name_14,
	[35] = gameforge.locale.gm_skill_name_15,
	[46] = gameforge.locale.gm_skill_name_16,
	[47] = gameforge.locale.gm_skill_name_17,
	[48] = gameforge.locale.gm_skill_name_18,
	[49] = gameforge.locale.gm_skill_name_19,
	[50] = gameforge.locale.gm_skill_name_20,
	[61] = gameforge.locale.gm_skill_name_21,
	[62] = gameforge.locale.gm_skill_name_22,
	[63] = gameforge.locale.gm_skill_name_23,
	[64] = gameforge.locale.gm_skill_name_24,
	[65] = gameforge.locale.gm_skill_name_25,
	[66] = gameforge.locale.gm_skill_name_26,
	[76] = gameforge.locale.gm_skill_name_27,
	[77] = gameforge.locale.gm_skill_name_28,
	[78] = gameforge.locale.gm_skill_name_29,
	[79] = gameforge.locale.gm_skill_name_30,
	[80] = gameforge.locale.gm_skill_name_31,
	[81] = gameforge.locale.gm_skill_name_32,
	[91] = gameforge.locale.gm_skill_name_33,
	[92] = gameforge.locale.gm_skill_name_34,
	[93] = gameforge.locale.gm_skill_name_35,
	[94] = gameforge.locale.gm_skill_name_36,
	[95] = gameforge.locale.gm_skill_name_37,
	[96] = gameforge.locale.gm_skill_name_38,
	[106] = gameforge.locale.gm_skill_name_39,
	[107] = gameforge.locale.gm_skill_name_40,
	[108] = gameforge.locale.gm_skill_name_41,
	[109] = gameforge.locale.gm_skill_name_42,
	[110] = gameforge.locale.gm_skill_name_43,
	[111] = gameforge.locale.gm_skill_name_44,
}
locale.dungeon = {}
locale.dungeon.time_limit_party = "Partinizin zindan kalma süresi henüz dolmadığı için giriş sınırlı."
locale.dungeon.time_limit = "Zindan kalma süresi henüz dolmadığı için giriş sınırlı."
locale.dungeon.no_ticket_party = "Parti üyelerinden birinin giriş belgesi yok."
locale.dungeon.no_ticket = "Giriş belgesi yok."
locale.dungeon.level_limit_party = "Parti üyelerinden biri %d. seviyeye ulaşmadı."
locale.dungeon.level_limit = "%d. seviyeye ulaşmadın."
locale.dungeon.leader_can_go = "Sadece parti lideri gidebilir."
locale.dungeon.enter_yes = "Gir"
locale.dungeon.enter_no = "Girme"
locale.dungeon.leader_can_enter = "Sadece parti lideri giriş için başvurabilir."
locale.dungeon.party_can_enter = "Zindan girişi parti bazlıdır."

locale.flame_dungeon = {}
locale.flame_dungeon.say_1 = "Alev Kralı Yamacheon'u cezalandırmak istediğinizden emin misiniz?"
locale.flame_dungeon.say_2 = "Gir"
locale.flame_dungeon.say_3 = "Kapat"
locale.flame_dungeon.say_4 = "Parti üyelerinin hepsi 103. seviye görevlerini tamamlamadı, ilerlemek mümkün değil."
locale.flame_dungeon.say_5 = "Partinizin zindan kalma süresi henüz dolmadığı için giriş sınırlı."
locale.flame_dungeon.say_6 = "Zindan kalma süresi henüz dolmadığı için giriş sınırlı."
locale.flame_dungeon.say_7 = "Bu alana parti üyesi giriş onayı verilmedi."
locale.flame_dungeon.say_8 = "Giriş belgesi teslim edilmedi."
locale.flame_dungeon.say_9 = "Parti üyelerinin hepsi 100. seviyeye ulaşmadı."
locale.flame_dungeon.say_10 = "Henüz 100. seviyeye ulaşmadın."
locale.flame_dungeon.say_11 = "Kızıl Ejder Kalesi"
locale.flame_dungeon.say_12 = "Kızıl Ejder Kalesi'ne gitmek istiyor musunuz?"
locale.flame_dungeon.say_13 = "Gir"
locale.flame_dungeon.say_14 = "Girme"
locale.flame_dungeon.say_15 = "Sadece parti lideri giriş için başvurabilir."
locale.flame_dungeon.say_16 = "Zindan girişi parti bazlıdır."
locale.flame_dungeon.say_17 = "Kalma süresi dolunca Kızıl Ejder Kalesi'nden çıkarılacaksınız."
locale.flame_dungeon.say_18 = "Kızıl Ejder Kalesi kalma süresi %d dakika."
locale.flame_dungeon.say_19 = "Kızıl Ejder Kalesi'ndeki kalma süresi tamamen doldu."
locale.flame_dungeon.say_20 = "Yaklaşık 10 saniye içinde Kızıl Ejder Kalesi'nden çıkarılacaksınız."
locale.flame_dungeon.say_21 = "Kızıl Ejder Kalesi'ne girildi."
locale.flame_dungeon.say_22 = "Sadece parti lideri gidebilir."
locale.flame_dungeon.say_23 = "Kızıl Ejder mührü kapandı."
locale.flame_dungeon.say_24 = "Kızıl Ejder Kalesi kalma süresi 1 saattir; süre dolmadan tamamlanır veya mühürler 30 dakika içinde çözülemezse pozisyon sınırlıdır."
locale.flame_dungeon.say_25 = "Kızıl Ejder Kalesi kalma süresi dolmak üzere."
locale.flame_dungeon.say_26 = "Kızıl Ejder mühürlerini bulup çözün; tüm kötülüğü yenin."
locale.flame_dungeon.say_27 = "Tüm kötülük henüz yenilmedi."
locale.flame_dungeon.say_28 = "Kalanları öldürün: "
locale.flame_dungeon.say_29 = "Mühürlü taşları bulup mühürlerini çözün."
locale.flame_dungeon.say_30 = "Mührü çözmek için gereken anahtarı ele geçirmelisiniz."
locale.flame_dungeon.say_31 = "Mühür yalnızca gerçek anahtarla çözülebilir."
locale.flame_dungeon.say_32 = "Gizemli mühür taşının nerede olduğunu bulun."
locale.flame_dungeon.say_33 = "Gerçek mühür taşı sağlam; mühür çözülemez."
locale.flame_dungeon.say_34 = "Gerçek mühür taşını bulun."
locale.flame_dungeon.say_35 = "Mührü çözecek taşı bulun."
locale.flame_dungeon.say_36 = "Mühür taşı tapınağında kötü ruhlar ortaya çıkar."
locale.flame_dungeon.say_37 = "Mühür taşlarının ikisi de çözülmedi."
locale.flame_dungeon.say_38 = "Yok edilecek ocaktaşını bulun."
locale.flame_dungeon.say_39 = "Ocaktaşları tek tek yok edilmeli; kötülerle dolular."
locale.flame_dungeon.say_40 = "Ocaktaşını bulun ve yok edin."
locale.flame_dungeon.say_41 = "Yamacheon'u alt edin!"
locale.flame_dungeon.say_42 = "Tüm canavarlar yenildi."
locale.flame_dungeon.say_43 = "Bir sonraki mühür taşı ortaya çıkacak."
locale.flame_dungeon.say_44 = "İkisi de mühürlendi."
locale.flame_dungeon.say_45 = "Bu gerçek anahtar değil."
locale.flame_dungeon.say_46 = "Külçe, gerçek yakıcı tarafından yok edildi."
locale.flame_dungeon.say_47 = "Lütfen ikinci büyüyü kaldırın."
locale.flame_dungeon.say_48 = "Lütfen üçüncü zinciri kaldırın."
locale.flame_dungeon.say_49 = "Yanlış sıra."
locale.flame_dungeon.say_50 = "Lütfen dördüncü zinciri kaldırın."
locale.flame_dungeon.say_51 = "Önce dört ya da beş zincir taşından ilkini kaldırın."
locale.flame_dungeon.say_52 = "Önce dört ya da beş zincir taşından ilkini kaldırın."
locale.flame_dungeon.say_53 = "Önce dört ya da beş zincir taşından ilkini kaldırın."
locale.flame_dungeon.say_54 = "Ocaktaşı yok edildi."
locale.flame_dungeon.say_55 = "Alev Kralı Yamacheon yenildi."
locale.flame_dungeon.say_56 = "Bir dakika içinde Kızıl Ejder Kalesi'nden çıkarılacaksınız."
locale.flame_dungeon.say_57 = "Parti üyelerinin hepsi 104. seviyeyi tamamlamadı, ilerlemek mümkün değil."
locale.flame_dungeon.say_58 = "Parti engeli kalkmadan ilerlenemez.[ENTER]"
locale.flame_dungeon.say_59 = "Yeniden giriş süresi 5 dakikayı aştı, izin verilmez.[ENTER]"
locale.flame_dungeon.say_60 = "Parti zindanı başlatmadı."

locale.main_quest_flame_lv99 = {}
locale.main_quest_flame_lv99.say_1 = "Yeniden Başlayan Takip"
locale.main_quest_flame_lv99.say_2 = "Yak-Hwan(20377) seni aceleyle arıyor.[ENTER]Ayrıntıları öğrenmek için Yak-Hwan(20377) ile konuş.[ENTER]"
locale.main_quest_flame_lv99.say_3 = "Hoş geldin.[ENTER]Geçen sefer İblis Tarikatı'nın büyüsünü engellerken epey zorlandın.[ENTER]Tarikatın bu şekilde geri çekilmeyeceğinden emindim.[ENTER]Bu yüzden kullanabildiğim tüm istihbarat ağını harekete geçirip takibi sürdürdüm.[ENTER]"
locale.main_quest_flame_lv99.say_4 = "Evet. Beni böyle çağırdığınıza göre bir şey mi buldunuz?[ENTER]"
locale.main_quest_flame_lv99.say_5 = "Öyle.[ENTER]Ama dediğim gibi bunlar sadece şüphe; doğrudan doğrulayamadım.[ENTER]Bu yüzden benim için kontrol etmeni istiyorum.[ENTER]"
locale.main_quest_flame_lv99.say_6 = "Son zamanlarda Alev Toprakları'nda işlerin yolunda gitmediğine dair bilgiler sık geliyor; bir adamımı kontrol için göndermeyi düşündüm.[ENTER]Dövüş sanatlarında usta olmasına rağmen geri dönmedi.[ENTER]Alev Toprakları'ndaki sıradan yaratıkların bile baş edemediği biri; kesin bir şey oldu.[ENTER]Alev Toprakları'na gidip ne olduğunu öğrenip gel.[ENTER]Adamımı bulursan hemen geri dönmesini de söyle.[ENTER]"
locale.main_quest_flame_lv99.say_7 = "Evet. Anlaşıldı.[ENTER]"
locale.main_quest_flame_lv99.say_8 = "Adamımla posta güverciniyle mektuplaşırken yaklaşık konumu tespit ettim; haritada işaretlediğim yere gitmen yeterli.[ENTER]Hadi git.[ENTER]"
locale.main_quest_flame_lv99.say_9 = "Yak-Hwan(20377) Alev Toprakları haritasında bir yer işaretledi.[ENTER]Kontrol edilecek nokta: (%d,%d)."
locale.main_quest_flame_lv99.say_10 = "Alev Toprakları'nı keşfedelim!"
locale.main_quest_flame_lv99.say_11 = "Yak-Hwan(20377)'in söylediği yeri keşfedelim.[ENTER]"
locale.main_quest_flame_lv99.say_12 = "Haritada işaretlediğim yerde kesinlikle bir şey olmalı.[ENTER]İyice bakıp geldin mi?[ENTER]Aciliyeti olan bir iş; hemen git gel.[ENTER]"
locale.main_quest_flame_lv99.say_13 = "Yak-Hwan(20377)'in belirttiği bölgeye ulaştın.[ENTER]Yak-Hwan(20377)'e dönüp rapor ver."
locale.main_quest_flame_lv99.say_14 = "Kötü Ejder Ordusu'ndaki Yak-Hwan(20377)'i bulup konuşalım.[ENTER]"
locale.main_quest_flame_lv99.say_15 = "Oh! Dönmüşsün.[ENTER]Bir şey bulabildin mi?[ENTER]"
locale.main_quest_flame_lv99.say_16 = "Haritada işaretlediğiniz yere gittim ama ne yazık ki adamınızın izini bulamadım.[ENTER]Çevreyi incelerken yaratık seslerinin gürültülü geldiği, ürkütücü bir mağara buldum.[ENTER]"
locale.main_quest_flame_lv99.say_17 = "Öyle mi.[ENTER]Galiba bir şeyler ters gidiyor.[ENTER]Söylediğin bölgeyi daha fazla araştırıp seni tekrar çağıracağım.[ENTER]"
locale.main_quest_flame_lv99.say_18 = "Araştırma 1-1"
locale.main_quest_flame_lv99.say_19 = "Bana bildirdiğin o mağarayı araştırmak için çok uğraştım ama henüz bir sonuca varamadım.[ENTER]Görünen o ki Yon-I Gezgini(20380)'nin yardımına şiddetle ihtiyacımız var.[ENTER]Sana bir mektup vereceğim; onu Yon-I Gezgini(20380)'e ulaştır.[ENTER]Mektubu görünce durumu anlar ve yardım eder.[ENTER]"
locale.main_quest_flame_lv99.say_20 = "Kötü Ejder Ordusu'ndaki Yon-I Gezgini(20380)'ni bulup konuşalım.[ENTER]"
locale.main_quest_flame_lv99.say_21 = "(mırıl mırıl)[ENTER]Vay be…bu adam her seferinde insanı korkutuyor…[ENTER]Gelince haber vermen gerekmez mi?[ENTER]Ee, ne işin var?[ENTER]"
locale.main_quest_flame_lv99.say_22 = "Yak-Hwan(20377) bu mektubu sana iletmemi istedi.[ENTER]"
locale.main_quest_flame_lv99.say_23 = "Hmm…Yak-Hwan(20377)'in mektubuna bakılırsa endişelendiği şeyi anlıyorum.[ENTER]Kesin olan her şey iyidir; bana biraz yardım et.[ENTER]"
locale.main_quest_flame_lv99.say_24 = "Gittiğin o mağaranın çevresini araştırmalıyız sanırım.[ENTER]Önce çevreyi araştırmak iyi olur. Önden atılırsak işi bozarız.[ENTER]Mağaradan ürkütücü sesler geldiğini söyledin; çevredeki yaratıklar da etkilenmiş olabilir.[ENTER]Sana bir kâğıt vereceğim; onu silahına sar ve çevredeki yaratıkları öldür.[ENTER]Kara enerjiden çok etkilenen bir yaratığı öldürünce kâğıt kararacak.[ENTER]"
locale.main_quest_flame_lv99.say_25 = "Yak-Hwan(20377)'e bildirdiğin mağara çevresindeki yaratıkları öldürelim."
locale.main_quest_flame_lv99.say_26 = "Mağara çevresindeki yaratıkları öldürelim."
locale.main_quest_flame_lv99.say_27 = "Yak-Hwan(20377)'e bildirdiğin mağara çevresindeki yaratıkları öldürelim.[ENTER]"
locale.main_quest_flame_lv99.say_28 = "Hmm…çevredeki yaratıklar kesinlikle kara enerjiden etkilenmiş olmalı.[ENTER]Düzgün kontrol ettin mi?[ENTER]Bir kez daha git gel.[ENTER]"
locale.main_quest_flame_lv99.say_29 = "Yon-I Gezgini(20380)'nin verdiği kâğıt karardı. Yon-I Gezgini(20380)'e götür."
locale.main_quest_flame_lv99.say_30 = "Geldin mi.[ENTER]Hmm…demek kara enerjiden etkilenen yaratıklar her yere yayılmış.[ENTER]Bu kâğıda sinen kara enerjiyi araştırmam gerek; şimdilik dön ve dinlen.[ENTER]"
locale.main_quest_flame_lv99.say_31 = "Araştırma 1-2"
locale.main_quest_flame_lv99.say_32 = "Yon-I Gezgini(20380) seni aceleyle arıyor.[ENTER]Ayrıntıları öğrenmek için Yon-I Gezgini(20380) ile konuş.[ENTER]"
locale.main_quest_flame_lv99.say_33 = "Hoş geldin.[ENTER]Getirdiğin kara enerji sinmiş kâğıdı inceliyordum.[ENTER]Kara enerji sıradan insanın zihnini bulandırdığından tütsü yakarak araştırmak gerekir.[ENTER]Ne var ki tam araştırma yaparken tütsü için gereken şifalı otlar tükendi.[ENTER]"
locale.main_quest_flame_lv99.say_34 = "Anlıyorum. İşler ters görünüyor; hemen otları getireyim.[ENTER]"
locale.main_quest_flame_lv99.say_35 = "He he.[ENTER]Her zamanki gibi çabuk kavrıyorsun…[ENTER]Şifalı otlar yin enerjisini bastırmada önemli rol oynar.[ENTER]Bu yüzden yang enerjisinin bol olduğu yerde yetişir.[ENTER]Alev Toprakları'nı biliyorsun; en ucundadır, sen git.[ENTER]Bu haritaya bakıp gitmen yeterli.[ENTER]Tabii hafızam biraz bulanık, pek kesin değil.[ENTER]"
locale.main_quest_flame_lv99.say_36 = "Evet. Anlaşıldı.[ENTER]Hemen gidip geleceğim.[ENTER]"
locale.main_quest_flame_lv99.say_37 = "Yon-I Gezgini(20380)'nin haritada işaretlediği yerden Güneş Bitkileri(31076) getir."
locale.main_quest_flame_lv99.say_38 = "Güneş Bitkileri(31076) bulalım."
locale.main_quest_flame_lv99.say_39 = "Yon-I Gezgini(20380)'nin verdiği haritadaki konumdan otu getir.[ENTER]"
locale.main_quest_flame_lv99.say_40 = "Hey…[ENTER]Elin boş gelirsen ne yapalım?[ENTER]O Güneş Bitkileri(31076) olmadan araştırmaya devam edemem.[ENTER]Yeniden git gel.[ENTER]"
locale.main_quest_flame_lv99.say_41 = "Yon-I Gezgini(20380)'nin bahsettiği Güneş Bitkileri(31076)'ni buldun. Yon-I Gezgini(20380)'e götür."
locale.main_quest_flame_lv99.say_42 = "Evet. Tam da bu ot.[ENTER]Artık araştırmayı bitirebiliriz.[ENTER]Araştırma bitince Yak-Hwan(20377)'e haber veririm; sonra ona uğra.[ENTER]"

locale.main_quest_flame_lv100 = {}
locale.main_quest_flame_lv100.say_1 = "Kara Enerjinin Aslı"
locale.main_quest_flame_lv100.say_2 = "Yak-Hwan(20377) seni aceleyle arıyor.[ENTER]Ayrıntıları öğrenmek için Yak-Hwan(20377) ile konuş.[ENTER]"
locale.main_quest_flame_lv100.say_3 = "Hoş geldin.[ENTER]Yon-I Gezgini(20380)'ne yardım ettiğin için araştırma sorunsuz tamamlandı.[ENTER]Önce araştırmanın sonucunu sana aktarayım.[ENTER]"
locale.main_quest_flame_lv100.say_4 = "Yon-I Gezgini(20380)'ye göre, seninle araştırdığımız o mağara civarındaki yaratıklar özlerinden farklı bir enerji yüzünden[ENTER]değişime uğramış.[ENTER]Etki sürerse yaratıklar giderek güçlenir, mutasyona uğrar ve daha vahşi bir hâl alırlarmış.[ENTER]Önce kara enerjinin yayılmasını durdurmalıyız ki çevreye zarar az olsun.[ENTER]"
locale.main_quest_flame_lv100.say_5 = "O hâlde kara enerjinin yayılmasını durdurmak için ne yapmalıyız?[ENTER]"
locale.main_quest_flame_lv100.say_6 = "Onun için de kara enerjinin yayılmasını durdurmak üzere Simyacı(20001) ile görüştüm.[ENTER]Simyacı(20001) engelleme yöntemini hazırlıyor; daha fazla yayılmaması için yaratıkları öldür.[ENTER]Mağara civarındaki yaratıklardan ayrım gözetmeden 300 kadar öldürürsen iyi olur.[ENTER]"
locale.main_quest_flame_lv100.say_7 = "Evet. Hemen yola çıkıyorum.[ENTER]"
locale.main_quest_flame_lv100.say_8 = "Teşekkürler. İyi bir sonuç bekliyorum.[ENTER]"
locale.main_quest_flame_lv100.say_9 = "Yak-Hwan(20377) ile araştırdığımız yerin çevresindeki yaratıkları öldürelim."
locale.main_quest_flame_lv100.say_10 = "Alev Toprakları'ndaki yaratıkları öldürelim!"
locale.main_quest_flame_lv100.say_11 = "Yak-Hwan(20377) ile araştırdığımız yerin çevresindeki yaratıkları öldürelim.[ENTER]"
locale.main_quest_flame_lv100.say_12 = "Gerçekten yeterince öldürüp geldin mi?[ENTER]Adamlarımın raporuna göre henüz yeterli görünmüyor.[ENTER]Hemen git hepsini öldür gel.[ENTER]"
locale.main_quest_flame_lv100.say_13 = "Çevredeki yaratıkları yeterince öldürdün.[ENTER]Yak-Hwan(20377)'e rapor ver."
locale.main_quest_flame_lv100.say_14 = "Kötü Ejder Ordusu'ndaki Yak-Hwan(20377)'i bulup konuşalım.[ENTER]"
locale.main_quest_flame_lv100.say_15 = "Hmm…bu kadarı yeterince yaratık öldürülmüş gibi…[ENTER]Çevredeki yaratıkları öldürdüğünü Simyacı(20001)'e ben bildiririm; sen dinlen.[ENTER]"
locale.main_quest_flame_lv100.say_16 = "Kara Enerjiyi Durdurma 1-1"
locale.main_quest_flame_lv100.say_17 = "Simyacı(20001) seni aceleyle arıyor.[ENTER]Ayrıntıları öğrenmek için Simyacı(20001) ile konuş.[ENTER]"
locale.main_quest_flame_lv100.say_18 = "Kahretsin…[ENTER]Yak-Hwan(20377)'e ne kadar temkinli olmasını rica etmiştim ama iş büyüdü.[ENTER]Kara enerji, yaratık ölürken özellikle daha çok yayılır; 300 yaratığı katledince büyük iş oldu.[ENTER]"
locale.main_quest_flame_lv100.say_19 = "Şu an durum daha da kötüye gidiyor.[ENTER]Üstelik kara enerjiyi durdurmak için yaptığım iksir(31084) de yetersiz kaldı.[ENTER]Bu ilacı silaha sürüp yaratık öldürürsen kara enerjinin yayılması engellenir.[ENTER]Yetersiz kaldığı için senin daha fazla malzeme temin etmen gerek.[ENTER]"
locale.main_quest_flame_lv100.say_20 = "Evet. Anlaşıldı. Malzemeler neler?[ENTER]"
locale.main_quest_flame_lv100.say_21 = "İyi temin edebilir misin şüpheliyim…[ENTER]Bulunması hiç kolay şeyler değil…[ENTER]Yine de söyleyeyim!![ENTER]İksir(31084) yapmak için Temel Taşı(90010) 10 adet, Ayı Safrası(30010) 50 adet, Örümceğin Zehir Kesesi(30025) 10 adet, Enerji Parçası(51001) 200 adet gerekir.[ENTER]Senin gibi bir savaşçı nereden bulacağını bilir; açıklamayı es geçiyorum.[ENTER]"
locale.main_quest_flame_lv100.say_22 = "Kolay bulunacak malzemeler değilmiş. Gidip getireyim.[ENTER]"
locale.main_quest_flame_lv100.say_23 = "Tamam. Biz böyle konuşurken bile kara enerji yayılıyor; acele et.[ENTER]"
locale.main_quest_flame_lv100.say_24 = "Simyacı(20001)'e yardım edip iksiri(31084) tamamlayalım."
locale.main_quest_flame_lv100.say_25 = "Kalan malzeme"
locale.main_quest_flame_lv100.say_26 = "İksir(31084) yapacak malzemeyi bulalım."
locale.main_quest_flame_lv100.say_27 = "Simyacı(20001)'in söylediği malzemeleri getirelim.[ENTER]"
locale.main_quest_flame_lv100.say_28 = "Oh~toplanması kolay olmayan malzemelerdi.[ENTER]İyi getirmişsin.[ENTER]İksiri(31084) yapıp seni çağırırım; gidebilirsin.[ENTER]"
locale.main_quest_flame_lv100.say_29 = "Hey. Beni sayı saymayı bilmeyen kör mü sanıyorsun?[ENTER]Hemen tüm malzemeyi getir.[ENTER]Şu anda bile kara enerji azgınlaşıyor.[ENTER]"
locale.main_quest_flame_lv100.say_30 = "İksir(31084) için gereken malzemenin hepsini topladın. Simyacı(20001)'e ver."
locale.main_quest_flame_lv100.say_31 = "Kötü Ejder Ordusu'ndaki Simyacı(20001)'i bulup konuşalım.[ENTER]"
locale.main_quest_flame_lv100.say_32 = "Kara Enerjiyi Durdurma 1-2"
locale.main_quest_flame_lv100.say_33 = "Vay vay…[ENTER]Geçen ilaç yaparken Demirci(20016)'ye söylendim diye Temel Taşı(90010)'nı toz yapmayı reddediyor…[ENTER]Temel Taşı(90010)'nı toz yapıp diğer malzemelerle karıştırarak ilacı tamamlarız…[ENTER]Gururum elvermiyor; sen bunu götürüp Temel Taşı(90010)'nı toz yaptırıp getirir misin?[ENTER]"
locale.main_quest_flame_lv100.say_34 = "Ne yaptınız ki…[ENTER]Peki anlaşıldı. Temel Taşı(90010) ve sepeti verin.[ENTER]"
locale.main_quest_flame_lv100.say_35 = "Teşekkürler. Bekliyor olacağım.[ENTER]"
locale.main_quest_flame_lv100.say_36 = "Demirci(20016)'ye gidelim."
locale.main_quest_flame_lv100.say_37 = "Demirci(20016)'ye Temel Taşı(90010)'nı toz yaptıralım.[ENTER]"
locale.main_quest_flame_lv100.say_38 = "Temel Taşı(90010) tozu: 1 adet[ENTER]"
locale.main_quest_flame_lv100.say_39 = "Vay usta, buyurun?[ENTER]Kaliteli silah mı almaya geldiniz?[ENTER]"
locale.main_quest_flame_lv100.say_40 = "Ah~başka bir sebep var; Simyacı(20001)'den haberi duydum.[ENTER]Zamanın gereği yardım istemeye geldim.[ENTER]Simyacı(20001) bizzat gelip özür dileyemediği için üzgün ve bu yemek sepetini gönderdi.[ENTER]"
locale.main_quest_flame_lv100.say_41 = "Hmm…içim elvermese de…[ENTER]Ustayı bizzat bulup özür dilemişsiniz; o zaman Temel Taşı(90010)'nı öğüteyim.[ENTER]Biraz bekleyin.[ENTER]"
locale.main_quest_flame_lv100.say_42 = "Evet. Teşekkürler.[ENTER]"
locale.main_quest_flame_lv100.say_43 = "Hey. İki elinde de Temel Taşı(90010) ve sepet duruyor…[ENTER]Hemen gidip gel.[ENTER]"
locale.main_quest_flame_lv100.say_44 = "Temel Taşı(90010)'nın hepsi öğütüldü. Simyacı(20001)'e ver.[ENTER]"
locale.main_quest_flame_lv100.say_45 = "Oh~Demirci(20016) özrü kabul etmiş görünüyor.[ENTER]Ben de artık uslu yaşamalıyım…[ENTER]Toz yapılan Temel Taşı(90010)'nı bana ver ve dinlen.[ENTER]İlaç tamamlanınca seni çağırırım.[ENTER]"

locale.main_quest_flame_lv101 = {}
locale.main_quest_flame_lv101.say_1 = "Mağaranın Aslı"
locale.main_quest_flame_lv101.say_2 = "Yak-Hwan(20377) seni aceleyle arıyor.[ENTER]Ayrıntıları öğrenmek için Yak-Hwan(20377) ile konuş.[ENTER]"
locale.main_quest_flame_lv101.say_3 = "Hoş geldin.[ENTER]Simyacı(20001) çabalarını anlattı.[ENTER]Boş yere iş çıkarıp seni yordum galiba.[ENTER]Üzgünüm.[ENTER]"
locale.main_quest_flame_lv101.say_4 = "Özür özürdür ama durum daha da acilleşti; kısaca işini söyleyeyim.[ENTER]İksiri(31084) Simyacı(20001)'den teslim aldım.[ENTER]O ilacı silaha sürünce öldürülen yaratığın kara enerjisinin yayılması engellenir.[ENTER]"
locale.main_quest_flame_lv101.say_5 = "İlaç açıklaması bu kadar; şimdi yapman gerekeni söyleyeyim.[ENTER]Silah da hazır; bulduğumuz o mağarayı daha detaylı araştırmalıyız.[ENTER]Kara enerji yayılıyor; içeri girip yaratıkları öldürünce mutlaka bir ipucu çıkar.[ENTER]Sen bizzat girip kontrol et.[ENTER]"
locale.main_quest_flame_lv101.say_6 = "Ah…mağarada adamım bulunursa mutlaka sağ dönmesini söyle.[ENTER]Gezgin tüccara göre adamım içeri girmiş.[ENTER]"
locale.main_quest_flame_lv101.say_7 = "Evet. Hemen yola çıkıyorum.[ENTER]"
locale.main_quest_flame_lv101.say_8 = "Teşekkürler. İyi bir sonuç bekliyorum.[ENTER]"
locale.main_quest_flame_lv101.say_9 = "Mağaradaki yaratıkları öldürüp ipucu ve Yak-Hwan'ın adamı(20393)'nın akıbetini öğrenelim."
locale.main_quest_flame_lv101.say_10 = "Alev Toprakları'ndaki yaratıkları öldürelim!"
locale.main_quest_flame_lv101.say_11 = "Yak-Hwan(20377) ile araştırdığımız yerin çevresindeki yaratıkları öldürelim.[ENTER]"
locale.main_quest_flame_lv101.say_12 = "※Bu zindana tek başına girilemez.[ENTER]   Parti kurarak girin.[ENTER]※Verilen geçiş kartı yeniden düzenlenmez.[ENTER]"
locale.main_quest_flame_lv101.say_13 = "Hey. Boş olduğum için mi sana rica ettim sandın?[ENTER]Kesinlikle adamımın izi ve ipucu bulunur.[ENTER]Hemen git gel.[ENTER]"
locale.main_quest_flame_lv101.say_14 = "Adam ölü. Belinde kalan mektubu Yak-Hwan(20377)'e götür.[ENTER]"
locale.main_quest_flame_lv101.say_15 = "Yak-Hwan(20377)'in bahsettiği adamın(20393) akıbetini öğrendin."
locale.main_quest_flame_lv101.say_16 = "Adamın akıbeti ne?[ENTER]"
locale.main_quest_flame_lv101.say_17 = "…Ne yazık ki adamınız çoktan ölmüştü.[ENTER]Belinde bir mektup buldum, buyrun.[ENTER]"
locale.main_quest_flame_lv101.say_18 = "Mektubu sonra okurum.[ENTER]İpucunu alamadın galiba; hemen gidip ipucunu da alıp dön.[ENTER]"
locale.main_quest_flame_lv101.say_19 = "Yak-Hwan(20377)'in bahsettiği ipucunu buldun."
locale.main_quest_flame_lv101.say_20 = "Hmm…demek ipucu çıktı.[ENTER]Adamın akıbeti hâlâ bilinmiyor galiba.[ENTER]Adamım kesin o mağarada; hemen gidip tekrar kontrol et.[ENTER]"
locale.main_quest_flame_lv101.say_21 = "Yak-Hwan(20377)'in bahsettiği ipucunu ve adamının(20393) akıbetini öğrendin.[ENTER]Yak-Hwan(20377)'e rapor ver."
locale.main_quest_flame_lv101.say_22 = "Kötü Ejder Ordusu'ndaki Yak-Hwan(20377)'i bulup konuşalım.[ENTER]"
locale.main_quest_flame_lv101.say_23 = "Oh~döndün mü.[ENTER]İpucunu getirmişsin; diğer elindeki nedir?[ENTER]"
locale.main_quest_flame_lv101.say_24 = "Ah…bu adamınızın bıraktığı bir hatıra gibi görünüyor.[ENTER]Bulduğumda çoktan ölmüştü; bunu cebinde buldum.[ENTER]"
locale.main_quest_flame_lv101.say_25 = "Öyle mi…çok değer verdiğim bir adamdı…içeriğine bakıp tütsü yakmaya gitmeliyim…[ENTER]Önce mektubu birlikte okuyalım.[ENTER]"
locale.main_quest_flame_lv101.say_26 = "Yak-Hwan'ın Adamı(20393)"
locale.main_quest_flame_lv101.say_27 = "Bu mektubu bulan kişi lütfen Kötü Ejder Ordusu karargâhındaki Yak-Hwan(20377)'e ulaştırsın…(kısaltıldı)[ENTER]Yak-Hwan(20377) Bey, Alev Toprakları'nda yaratıkları araştırırken şüpheli bir mağara bulup girdim.[ENTER]Böylece geri dönemedim ve bu mektubu bırakıyorum.(kısaltıldı)[ENTER]Bu mağara, dışarıdaki yaratıklardan daha güçlü enerjili ve bir şeyi koruyor gibiydi.[ENTER]Mağaranın derinlerine indikçe uluma sesi güçleniyordu.[ENTER]Kesin bir şey var; bu mektubu görürseniz uygun biriyle araştırmanızı rica ederim.[ENTER]Görevi tamamlayamadığım için özür dilerim.[ENTER]"
locale.main_quest_flame_lv101.say_28 = "Sadık bir adamdı; yine gözlerim yaşardı.[ENTER]Bu mağara kesinlikle tehlikeli; bundan sonra daha dikkatli araştırmalıyız.[ENTER]Bu plaka daha önce gördüğün gibi İblis Tarikatı'nın plakası.[ENTER]Yon-I Gezgini(20380)'e vereceğim; o seni ararsa git.[ENTER]"
locale.main_quest_flame_lv101.say_29 = "İblis Tarikatı Plakasını Çözme"
locale.main_quest_flame_lv101.say_30 = "Yon-I Gezgini(20380) seni aceleyle arıyor.[ENTER]Ayrıntıları öğrenmek için Yon-I Gezgini(20380) ile konuş.[ENTER]"
locale.main_quest_flame_lv101.say_31 = "Hoş geldin.[ENTER]Seni bekliyordum.[ENTER]Yak-Hwan(20377)'in gönderdiği plakayı görünce yine şaşırmadan edemedim.[ENTER]Yak-Hwan(20377), bu plaka çözülürse mağarada olup biteni öğrenebiliriz dedi.[ENTER]O yüzden bana yardım edip bu plakayı çözmemi sağla.[ENTER]"
locale.main_quest_flame_lv101.say_32 = "Evet. Elbette![ENTER]"
locale.main_quest_flame_lv101.say_33 = "İyi bir tavır.[ENTER]Teslim aldıktan sonra plakayı yakından inceledim; sonuçta plakanın antik bir dille yazıldığını gördüm.[ENTER]Bu dili hemen çözüp bildirmek isterim ama savaşta hasar gördüğü için okunamıyor.[ENTER]Bu plakayı onarmak için alevden daha sıcak yanan bir kan gerekir.[ENTER]Kısaca Alev Kralı'nın Kanı(31080) gerekli.[ENTER]Sana bu kutuyu vereceğim; Alev Kral(2206)'ı öldürüp kanı buraya topla getir.[ENTER]"
locale.main_quest_flame_lv101.say_34 = "Evet. Anlaşıldı.[ENTER]"
locale.main_quest_flame_lv101.say_35 = "Getirince hemen dön. O kutu Alev Kralı'nın Kanı(31080)'na uzun süre dayanamaz.[ENTER]"
locale.main_quest_flame_lv101.say_36 = "Alev Toprakları'ndaki Alev Kral(2206)'ı öldürüp kanı kutuya dolduralım."
locale.main_quest_flame_lv101.say_37 = "Plakayı çözmek istemiyor musun?[ENTER]Hemen gidip Alev Kralı'nın Kanı(31080) getir.[ENTER]"
locale.main_quest_flame_lv101.say_38 = "Alev Kral(2206)'dan kanı aldın. Yon-I Gezgini(20380)'e dön."
locale.main_quest_flame_lv101.say_39 = "Kötü Ejder Ordusu'ndaki Yon-I Gezgini(20380)'ni bulup konuşalım.[ENTER]"
locale.main_quest_flame_lv101.say_40 = "Hmm…Alev Kralı'nın Kanı(31080) doğru.[ENTER]Onarım biraz zaman alır; yarın tekrar gel.[ENTER]Ben de çabuk isterim ama yapacak bir şey yok.[ENTER]"
locale.main_quest_flame_lv101.say_41 = "Kalan süre: %d saat %d dakika"
locale.main_quest_flame_lv101.say_42 = "Henüz vakti gelmedi mi?[ENTER]Sonra tekrar gel.[ENTER]"
locale.main_quest_flame_lv101.say_43 = "Plakanın Gerçeği"
locale.main_quest_flame_lv101.say_44 = "Geldin mi.[ENTER]Plaka çözüldü.[ENTER]Çözerken önce ben okudum; içinde korkunç şeyler var.[ENTER]Sana içeriğini aktarayım.[ENTER]"
locale.main_quest_flame_lv101.say_45 = "Plaka kesinlikle İblis Tarikatı'nın.[ENTER]Öldürürken plakayı bulduğun yaratık hangi yaratık bilmiyorum ama,[ENTER]İblis Tarikatı 6 ejderin mühürlendiği yere güçlü bir yaratık gönderip mührü kaldırmaya çalışıyormuş.[ENTER]Üstelik Ejder Birliği'nden de bahsediliyor.[ENTER]Ayrıntıları bu mektuba yazdım; Yak-Hwan(20377)'e ver.[ENTER]"
locale.main_quest_flame_lv101.say_46 = "Teşekkürler. Ayrıntıları Yak-Hwan(20377) anlatır.[ENTER]"
locale.main_quest_flame_lv101.say_47 = "Yon-I Gezgini(20380)'den aldığın mektubu Yak-Hwan(20377)'e götür."
locale.main_quest_flame_lv101.say_48 = "Yak-Hwan(20377)'e mektubu verelim!"
locale.main_quest_flame_lv101.say_49 = "Yon-I Gezgini(20380)'nin verdiği mektubu Yak-Hwan(20377)'e verelim.[ENTER]"
locale.main_quest_flame_lv101.say_50 = "Hoş geldin. Yon-I Gezgini(20380)'den haberi aldım.[ENTER]Mektubu ver.[ENTER]"
locale.main_quest_flame_lv101.say_51 = "Hmm…düşündüğümden ciddi.[ENTER]6 ejderin mühürlendiği yere İblis Tarikatı'nın yaratık gönderip mührü kaldırmaya çalıştığını duydun;[ENTER]Ejder Birliği'ni anlatayım.[ENTER]Yon-I Gezgini(20380)'ye göre Ejder Birliği, 6 ejderi gözetleyen ve kullanan çıkar ilişkisi olan bir güç.[ENTER]İblis Tarikatı da tehlikeli ama duruma göre onlar kadar tehlikeli olabilir.[ENTER]"
locale.main_quest_flame_lv101.say_52 = "Alev Toprakları'ndaki Alev Kral(2206)'ı öldürüp kan al.[ENTER]"
locale.main_quest_flame_lv101.say_53 = "Ejder Birliği zarar vermezse büyük sorun olmayabilir ama asıl odaklanmamız gereken[ENTER]İblis Tarikatı'nın 6 ejdere yaratık göndermesi.[ENTER]Üstelik Alev Toprakları ve 6 ejderin mührü düşünülünce o mağara Kızıl Ejder Kalesi(zone1) gibi görünüyor.[ENTER]Her hâlükârda Kızıl Ejder Kalesi(zone1)'nin içine girip cesurca araştırmak gerek.[ENTER]Bir yöntem hazırlayıp sana haber veririm; git dinlen.[ENTER]"

locale.main_quest_flame_lv102 = {}
locale.main_quest_flame_lv102.say_1 = "Baskın"
locale.main_quest_flame_lv102.say_2 = "Yak-Hwan(20377) seni aceleyle arıyor.[ENTER]Ayrıntıları öğrenmek için Yak-Hwan(20377) ile konuş.[ENTER]"
locale.main_quest_flame_lv102.say_3 = "Daha önce bahsettiğim Kızıl Ejder Kalesi(zone1) baskını yüzünden seni çağırdım.[ENTER]Dövüşü güçlü adamımın acımasızca öldürülmesi, oranın 6 ejderden Kızıl Ejder'in mühürlendiği yer olduğu tahmini gibi[ENTER]baskın için düşünülmesi gereken çok şey var.[ENTER]"
locale.main_quest_flame_lv102.say_4 = "Bana yardım edip Kızıl Ejder Kalesi(zone1) çevresindeki yaratıkları öldürerek kara enerjinin yayılmasını durdurdun; adamlarımla çevreyi ablukaya aldım.[ENTER]En azından dışarı zarar sıçramasını engelleyebiliriz.[ENTER]Şimdi senden istediğim, Kızıl Ejder Kalesi(zone1)'ne girip hangi yaratıklar olduğunu ve Kızıl Ejder'in gerçekten mühürlü olup olmadığını kontrol etmen.[ENTER]"
locale.main_quest_flame_lv102.say_5 = "Evet. Anlaşıldı.[ENTER]"
locale.main_quest_flame_lv102.say_6 = "Teşekkürler.[ENTER]Bir kez savaşmadan bilemeyiz; içerideki yaratıkları öldürüp kanıtları bana 30'ar adet getir.[ENTER]O hâlde sana güveniyorum.[ENTER]"
locale.main_quest_flame_lv102.say_7 = "Kızıl Ejder Kalesi(zone1)'ndeki yaratıkları öldürüp kanıtları getirelim."
locale.main_quest_flame_lv102.say_8 = "Kızıl Ejder Kalesi(zone1)'ne baskın yapalım!"
locale.main_quest_flame_lv102.say_9 = "Yak-Hwan(20377)'in emriyle Kızıl Ejder Kalesi(zone1)'ne girip keşif yapalım.[ENTER]"
locale.main_quest_flame_lv102.say_10 = "%s Pençesi: %d adet %s Tırnağı: %d adet"
locale.main_quest_flame_lv102.say_11 = "%s Zırh Parçası: %d adet %s Silah Parçası: %d adet"
locale.main_quest_flame_lv102.say_12 = "Hmm…bir miktar öldürmeden yaratıkların gücünü anlayıp strateji kuramayız.[ENTER]Hemen girip tüm kanıtları getir.[ENTER]"
locale.main_quest_flame_lv102.say_13 = "Kızıl Ejder Kalesi(zone1)'ndeki yaratıkları öldürmenin kanıtlarını topladın.[ENTER]Yak-Hwan(20377)'e rapor ver."
locale.main_quest_flame_lv102.say_14 = "Kötü Ejder Ordusu'ndaki Yak-Hwan(20377)'i bulup konuşalım.[ENTER]"
locale.main_quest_flame_lv102.say_15 = "Oh~geldin mi.[ENTER]Görünüşe göre kanıtların hepsini getirdin.[ENTER]Bizzat hissettiğin nasıldı?[ENTER]"
locale.main_quest_flame_lv102.say_16 = "Alev Toprakları'ndaki yaratıkları da gördüm ama Kızıl Ejder Kalesi(zone1) dışındaki yaratıklardan biraz güçlüydüler.[ENTER]Ayrıca ilk kez gördüğüm güçlü yaratıklar da çıktı; az kalsın sağ dönemezdim.[ENTER]Baskın sonucunda Kızıl Ejder'in mührünü kaldırmaya yardım eden ve Kızıl Ejder Kalesi(zone1)'ni koruyan Razadör(6091) adlı yaratığı tespit ettim.[ENTER]"
locale.main_quest_flame_lv102.say_17 = "Öyle mi. Sorun sadece kara enerjinin etkisi değilmiş.[ENTER]İblis Tarikatı bu sefer cidden gizlice hareket etmiş.[ENTER]Seni tekrar çağırırım; git.[ENTER]"
locale.main_quest_flame_lv102.say_18 = "Razadör(6091)?!"
locale.main_quest_flame_lv102.say_19 = "Yon-I Gezgini(20380) seni aceleyle arıyor.[ENTER]Ayrıntıları öğrenmek için Yon-I Gezgini(20380) ile konuş.[ENTER]"
locale.main_quest_flame_lv102.say_20 = "Yak-Hwan(20377)'den duydum.[ENTER]Kızıl Ejder Kalesi(zone1)'nde Razadör(6091)'i öğrenmişsin.[ENTER]Tam da o olmasın diye…[ENTER]"
locale.main_quest_flame_lv102.say_21 = "Bir sorun mu var…[ENTER]"
locale.main_quest_flame_lv102.say_22 = "Ne mi oldu!![ENTER]Razadör(6091), Buz İmparatoru Nemere(6191) ile birlikte en güçlü ve acımasız yaratıklardan biridir.[ENTER]Bu takibi sürdürürken en büyük engel olabilir.[ENTER]"
locale.main_quest_flame_lv102.say_23 = "Ben de eski kaynaklar ve söylentilerden biliyorum; daha doğru bilgi olmadan Yak-Hwan(20377)'e yardım edemem.[ENTER]Sen bana yardım edip Razadör(6091) hakkında bilgi topla.[ENTER]"
locale.main_quest_flame_lv102.say_24 = "Nasıl yardım edebilirim?[ENTER]"
locale.main_quest_flame_lv102.say_25 = "Razadör(6091)'in kara enerjiyi yayan fail olup olmadığı kesin değilken[ENTER]ona hemen karşı çıkmak tehlikeli olur.[ENTER]Önce Kızıl Ejder Kalesi(zone1)'deki yaratıkları yok et.[ENTER]Kara enerji sinen yaratıklar kesinlikle içinde kara enerji biriktirir.[ENTER]Kara enerjiyi arındırma yöntemi bulup sonra Razadör(6091)'e karşı çıkmak da geç kalmaz; Kara Madde(31081)'den 10 kadar getir.[ENTER]"
locale.main_quest_flame_lv102.say_26 = "Tamam. Bekliyor olacağım.[ENTER]"
locale.main_quest_flame_lv102.say_27 = "Kızıl Ejder Kalesi(zone1)'ndeki yaratıkları öldürüp Kara Madde(31081) getirelim."
locale.main_quest_flame_lv102.say_28 = "Kara Madde(31081) bulalım!"
locale.main_quest_flame_lv102.say_29 = "Kızıl Ejder Kalesi(zone1)'ne girip Kara Madde(31081) getir.[ENTER]"
locale.main_quest_flame_lv102.say_30 = "※Verilen geçiş kartı yeniden düzenlenmez.[ENTER]"
locale.main_quest_flame_lv102.say_31 = "Hey, hâlâ hepsini toplamadın mı?[ENTER]Sen bunu yapabilirsin sanmıştım…[ENTER]Tekrar git gel![ENTER]"
locale.main_quest_flame_lv102.say_32 = "Kızıl Ejder Kalesi(zone1) yaratıklarını öldürüp Kara Madde(31081)'nin hepsini aldın.[ENTER]Yon-I Gezgini(20380)'e rapor ver."
locale.main_quest_flame_lv102.say_33 = "Off~bakarken bile kara enerji vücuda siner gibi.[ENTER]Demek dövüşün güçlü.[ENTER]Kara Madde(31081) koyacak kutu vermeyi unuttum…[ENTER]Şimdi arındırma yöntemi bulup seni çağırırım.[ENTER]Git.[ENTER]"
locale.main_quest_flame_lv102.say_34 = "(Dikkatli olmak gerek sanırım…)[ENTER]"
locale.main_quest_flame_lv102.say_35 = "Kara Enerjiyi Arındırma"
locale.main_quest_flame_lv102.say_36 = "İyi geldin.[ENTER]Az önce kara enerjiyi arındırma yöntemi buldum.[ENTER]Ancak kara enerjiyi arındırabilirsek Kızıl Ejder Kalesi(zone1)'ne girip dayanabiliriz.[ENTER]Sen tek başına hepsini öldürürsen sorun yok ama bu imkânsız; Yak-Hwan(20377)'in adamlarıyla birlikte girersek[ENTER]biraz kolaylaşır ve kayıp azalır.[ENTER]"
locale.main_quest_flame_lv102.say_37 = "O yöntem nedir?[ENTER]"
locale.main_quest_flame_lv102.say_38 = "Acele ettirme.[ENTER]Zaten söyleyecektim.[ENTER]Geçenlerde kara enerjiyi araştırırken yin-yang uyumunu öğrendin; ayrıntıyı geçiyorum.[ENTER]Ateş ve su, yin ve yang gibi zıt nitelikler vardır!![ENTER]Kirli olanı berrak olanla nötrleyebiliriz.[ENTER]Tabii berraklık büyükse sonunda arındırma olur.[ENTER]"
locale.main_quest_flame_lv102.say_39 = "Mong Suyu(50819) diye bir şey bilirsin. Mong Suyu(50819)'na Enerji Parçası(51001) eritirsen berrak nitelikli bir sıvı olur.[ENTER]Bunu içip Kızıl Ejder Kalesi(zone1)'ndeki yaratıklarla savaşırsan büyük fayda sağlar.[ENTER]Söylemesi kolay ama kolayca tamamlanmaz; Mong Suyu(50819) 50 adet ve Enerji Parçası(51001) 100 kadar bulup Yu-Hwan(20017)'e götür.[ENTER]"
locale.main_quest_flame_lv102.say_40 = "Tamam. Bol şans.[ENTER]"
locale.main_quest_flame_lv102.say_41 = "Mong Suyu(50819) ve Enerji Parçası(51001) bulup Yu-Hwan(20017)'e götür."
locale.main_quest_flame_lv102.say_42 = "Kara enerji arındırma malzemesini bulalım!"
locale.main_quest_flame_lv102.say_43 = "Mong Suyu(50819) ve Enerji Parçası(51001) bulalım.[ENTER]"
locale.main_quest_flame_lv102.say_44 = "Bu adamın işi hızlı.[ENTER]Geri kalanını bana bırak; biraz dinlen.[ENTER]"
locale.main_quest_flame_lv102.say_45 = "Yon-I Gezgini(20380)'den duyduğumdan az.[ENTER]Hâlâ yeterince getirmemişsin.[ENTER]Hemen kalan malzemeyi de yeterince getir.[ENTER]"
locale.main_quest_flame_lv102.say_46 = "Mong Suyu(50819) ve Enerji Parçası(51001)'ni yeterince buldun. Yu-Hwan(20017)'e ver."
locale.main_quest_flame_lv102.say_47 = "Yu-Hwan(20017)'i bulup konuşalım.[ENTER]"
locale.main_quest_flame_lv102.say_48 = "Arındırma Sıvısını Teslim"
locale.main_quest_flame_lv102.say_49 = "Yu-Hwan(20017) seni aceleyle arıyor.[ENTER]Ayrıntıları öğrenmek için Yu-Hwan(20017) ile konuş.[ENTER]"
locale.main_quest_flame_lv102.say_50 = "Hoş geldin.[ENTER]Gönderdiğin malzemeyle arındırma sıvısı yaptım.[ENTER]Normalde daha çok çıkardı ama bir kısmı üretimde başarısız oldu ve miktar azaldı.[ENTER]Yine de yeterli çıktı; Yak-Hwan(20377)'e ver.[ENTER]"
locale.main_quest_flame_lv102.say_51 = "Ama sıvı demiştin; neden hap gibi sert?[ENTER]"
locale.main_quest_flame_lv102.say_52 = "Boş ver öyle küçük şeyleri.[ENTER]O kadar yoğunlaştı ki öyle oldu.[ENTER]"
locale.main_quest_flame_lv102.say_53 = "O hâlde sana güveniyorum.[ENTER]"
locale.main_quest_flame_lv102.say_54 = "Yu-Hwan(20017)'den aldığın arındırma sıvısını Yak-Hwan(20377)'e ver."
locale.main_quest_flame_lv102.say_55 = "Elinde hâlâ arındırma sıvısı neden var?[ENTER]Hemen Yak-Hwan(20377)'e arındırma sıvısını ver.[ENTER]"
locale.main_quest_flame_lv102.say_56 = "Oh~hoş geldin.[ENTER]Uzun süredir bekliyordum.[ENTER]Yu-Hwan(20017)'den de haberi aldım.[ENTER]Arındırma sıvısını getirdin mi?[ENTER]"
locale.main_quest_flame_lv102.say_57 = "Evet. Yoğunlaştırılıp neredeyse hap oldu.[ENTER]Kızıl Ejder Kalesi(zone1) baskınında işe yarar.[ENTER]"
locale.main_quest_flame_lv102.say_58 = "Öyle. Eline sağlık.[ENTER]Adamlarla baskın hazırlığı da yapmalıyız; arındırma sıvısını bırak git.[ENTER]Birini de sen al.[ENTER]Büyük güç ekseni sen olacaksın sanırım.[ENTER]Baskın zamanı seni çağırırım.[ENTER]"

locale.main_quest_flame_lv103 = {}
locale.main_quest_flame_lv103.say_1 = "Kızıl Ejder Kalesi(zone1)'ne Doğru"
locale.main_quest_flame_lv103.say_2 = "Yak-Hwan(20377) seni aceleyle arıyor.[ENTER]Ayrıntıları öğrenmek için Yak-Hwan(20377) ile konuş.[ENTER]"
locale.main_quest_flame_lv103.say_3 = "Hoş geldin.[ENTER]Stratejistlerle görüşüp seçkin askerleri ayırdım ve arındırma sıvısını erittiğim suyu içirdim.[ENTER]Etkisi müthişti.[ENTER]Tüm vücutta berrak bir enerji dolaştı, zihin açıldı ve güç arttı.[ENTER]Bu yüzden Kızıl Ejder Kalesi(zone1)'ne gönderdim.[ENTER]"
locale.main_quest_flame_lv103.say_4 = "Adamlarım önce yola çıktı; sen şimdi peşlerinden gidersen yetişirsin.[ENTER]Adamlarımla birlikte Kızıl Ejder Kalesi(zone1)'ni süpür; mümkünse Razadör(6091)'i de öldür.[ENTER]Öncelikle iletişim için gönderdiğim adamı bul; yapacağın işi sana söyler.[ENTER]"
locale.main_quest_flame_lv103.say_5 = "Evet. Anlaşıldı.[ENTER]"
locale.main_quest_flame_lv103.say_6 = "O hâlde sana güveniyorum.[ENTER]"
locale.main_quest_flame_lv103.say_7 = "Kızıl Ejder Kalesi(zone1)'nde Yak-Hwan'ın adamını(20393) bul."
locale.main_quest_flame_lv103.say_8 = "Yak-Hwan'ın adamını(20393) bul."
locale.main_quest_flame_lv103.say_9 = "Kızıl Ejder Kalesi(zone1)'ne giren Yak-Hwan'ın adamını(20393) bul.[ENTER]"
locale.main_quest_flame_lv103.say_10 = "Hey. Gitmeden niye geri geldin?[ENTER]Hemen Kızıl Ejder Kalesi(zone1)'ne yola çık.[ENTER]"
locale.main_quest_flame_lv103.say_11 = "Us…ta…buradayım…[ENTER]Yaratıkları yok edip girdim ama Razadör(6091)'in ezici gücü karşısında[ENTER]tamamen yok olduk.[ENTER]Tek başına çözülecek iş değil; Yak-Hwan(20377)'e bildir.[ENTER]"
locale.main_quest_flame_lv103.say_12 = "Kötü Ejder Ordusu'ndaki Yak-Hwan(20377)'i bulup konuşalım.[ENTER]"
locale.main_quest_flame_lv103.say_13 = "Düşündüğümden çabuk geldin.[ENTER]Kızıl Ejder Kalesi(zone1)'ni halledip mi geliyorsun?[ENTER]"
locale.main_quest_flame_lv103.say_14 = "Ah…şey…yani…[ENTER]"
locale.main_quest_flame_lv103.say_15 = "Neden öyle lafı geveliyorsun?[ENTER]Bir şey mi oldu?[ENTER]"
locale.main_quest_flame_lv103.say_16 = "Arındırma sıvısını içen askerler güçlenip Kızıl Ejder Kalesi(zone1)'ne girdi ama Razadör(6091) tarafından katledildi.[ENTER]Bunu son kalan asker güçlükle aktarıp öldü.[ENTER]Baskını biraz aceleyle yapmamız sorun oldu galiba.[ENTER]"
locale.main_quest_flame_lv103.say_17 = "Yaşlanınca ölmeli…[ENTER]Aceleci kararımla adamlarımı ölüme sürdüm…[ENTER]Düzeni toparlamalıyım.[ENTER]Haber gönderirim; bekle.[ENTER]"
locale.main_quest_flame_lv103.say_18 = "Kademeli İmha"
locale.main_quest_flame_lv103.say_19 = "Şimdi mi geliyorsun?[ENTER]Geçen sefer hatam yüzünden nice can yok oldu.[ENTER]İblis Tarikatı'nın komplosunu durdurmak gereken önemli zamanda vazgeçemezdim.[ENTER]Bu yüzden görüşmeler sonucu seni merkez alan bir plan hazırladım.[ENTER]"
locale.main_quest_flame_lv103.say_20 = "Senin dövüşün güçlü olduğundan buna uygun bir plan; çok zorlanma.[ENTER]Geçen sefer arındırma sıvısı kullanımı doğrulandı.[ENTER]Bu sefer de arındırma sıvısıyla askerleri güçlendireceğiz.[ENTER]Ama Razadör(6091)'i yenmek bizim için zor; askerlerimiz dışarı[ENTER]çıkmaya çalışan yaratıkları temizleyecek.[ENTER]"
locale.main_quest_flame_lv103.say_21 = "Bu sırada sen Kızıl Ejder Kalesi(zone1)'ne girip 1000 yaratığı ayırmadan yok et.[ENTER]Birkaç baskınla o kadar yaratık yok edersen Razadör(6091) de gerilir; sarsıntıda[ENTER]fırsat kesin gelir.[ENTER]Sana güveniyorum.[ENTER]"
locale.main_quest_flame_lv103.say_22 = "Evet. Anlaşıldı.[ENTER]"
locale.main_quest_flame_lv103.say_23 = "Kızıl Ejder Kalesi(zone1)'ne girip yaratıkları öldür."
locale.main_quest_flame_lv103.say_24 = "Yaratıkları katledelim."
locale.main_quest_flame_lv103.say_25 = "Kızıl Ejder Kalesi(zone1)'ne girip 1000 yaratığı yok et.[ENTER]"
locale.main_quest_flame_lv103.say_26 = "※Verilen geçiş kartı yeniden düzenlenmez.[ENTER]"
locale.main_quest_flame_lv103.say_27 = "Hâlâ hepsini yok edemedin galiba.[ENTER]Kızıl Ejder Kalesi(zone1) yaratıkları hâlâ dışarı taşkınlık yapıyor.[ENTER]Kısa yol aramadan hemen git gel.[ENTER]"
locale.main_quest_flame_lv103.say_28 = "Kızıl Ejder Kalesi(zone1)'ndeki 1000 yaratığı yok ettin.[ENTER]Yak-Hwan(20377)'e rapor ver."
locale.main_quest_flame_lv103.say_29 = "Adamlarıma göre Kızıl Ejder Kalesi(zone1)'den dışarı taşan yaratıklar neredeyse kalmadı.[ENTER]Yeterince yok etmişsin.[ENTER]Eline sağlık.[ENTER]Sonraki planı Yon-I Gezgini(20380) ile görüşüyorum; biraz bekle.[ENTER]"
locale.main_quest_flame_lv103.say_30 = "Kızıl Ejder Kalesi(zone1)'nin Baş Belası"
locale.main_quest_flame_lv103.say_31 = "İyi geldin.[ENTER]Yaratıkları yok ettiğin için baskın kolaylaşır sandım ama keşfe göre hâlâ zor.[ENTER]Sıradan yaratıkları öldürmek baskına etki etmeyecek.[ENTER]Bu yüzden keşif bilgisine göre komuta kademesi görünenleri önce öldürmeliyiz.[ENTER]"
locale.main_quest_flame_lv103.say_32 = "Onlar Kor Alev Kralı(6005), Kor Alev Sakallısı(6007), Kor Ateş Golemi(6006), Kor Alev Generali(6008), Kor Alev Lordu(6009) bu 5'i.[ENTER]Bunlar Kızıl Ejder Kalesi(zone1)'nde de üst düzey yaratıklar; Razadör(6091) hariç komuta kademesi sayılır.[ENTER]Yılanın başını kesmek gibi komuta kademesine büyük zarar verirsek planımız düzgün ilerler.[ENTER]O yüzden 5'ini de 50'şer öldür.[ENTER]"
locale.main_quest_flame_lv103.say_33 = "Kızıl Ejder Kalesi(zone1)'ne girip komuta yaratıklarını yok et."
locale.main_quest_flame_lv103.say_34 = "Kızıl Ejder Kalesi(zone1) komutasını yok et."
locale.main_quest_flame_lv103.say_35 = "Kızıl Ejder Kalesi(zone1)'ne girip komuta yaratıklarını öldür.[ENTER]"
locale.main_quest_flame_lv103.say_36 = "Komuta kademesini yeterince yok etmemişsin galiba.[ENTER]Planımız için gerekli operasyon; tekrar git gel.[ENTER]"
locale.main_quest_flame_lv103.say_37 = "Kızıl Ejder Kalesi(zone1) komuta yaratıklarının hepsini öldürdün.[ENTER]Yak-Hwan(20377)'e rapor ver."
locale.main_quest_flame_lv103.say_38 = "Artık Kızıl Ejder Kalesi(zone1)'ne girip İblis Tarikatı'nın komplosunu durdurabiliriz.[ENTER]Biraz daha ilerlemek yeter; biraz daha gayret et.[ENTER]Eline sağlık.[ENTER]"
locale.main_quest_flame_lv103.say_39 = "Razadör(6091) Seferi 1-1"
locale.main_quest_flame_lv103.say_40 = "Komutayı yok ettiğin için adamlarım rüzgârı yakalamış gemi gibi Kızıl Ejder Kalesi(zone1)'ni kademeli yok ediyor.[ENTER]Gerçekten payın büyük.[ENTER]Tekrar teşekkür ederim.[ENTER]Şimdi Kızıl Ejder Kalesi(zone1)'ni yok edip İblis Tarikatı'nın komplosunu durdurabiliriz.[ENTER]Seni durumu bildirmek ve teşekkür için çağırdım.[ENTER]Yon-I Gezgini(20380) bir plan düşündü; şimdi ona git.[ENTER]"
locale.main_quest_flame_lv103.say_41 = "Yon-I Gezgini(20380)'e gidip planı dinle."
locale.main_quest_flame_lv103.say_42 = "Yon-I Gezgini(20380)'e gidelim.[ENTER]"
locale.main_quest_flame_lv103.say_43 = "Hoş geldin. Seni bekliyordum.[ENTER]Yak-Hwan(20377)'den senin parlak zaferlerini sürekli duyuyordum.[ENTER]Önce onu geç; İblis Tarikatı'nın komplosunu engellemek önemli; planı anlatayım.[ENTER]"
locale.main_quest_flame_lv103.say_44 = "Yak-Hwan(20377)'in yardımıyla seçkin askerlerle Razadör(6091) hakkında araştırma yaptım.[ENTER]Büyük kazanç elde ettim.[ENTER]Razadör(6091), yaratıkların kaynadığı yere saklanan Cehennem Ateşi Metini(8057)'nden güç alıyor gibi.[ENTER]O Cehennem Ateşi Metini(8057)'ni kaldırırsak Razadör(6091)'i yenmek çok kolaylaşır.[ENTER]"
locale.main_quest_flame_lv103.say_45 = "O hâlde o Cehennem Ateşi Metini(8057)'ni kaldırıp gelirsem olur mu?[ENTER]"
locale.main_quest_flame_lv103.say_46 = "Öyle.[ENTER]Bildiğin gibi Cehennem Ateşi Metini(8057) kırılınca yaratıklar çokça ortaya çıkar.[ENTER]Bunu unutup dikkatsiz olma; cesurca hareket et.[ENTER]Cehennem Ateşi Metini(8057)'ni nerede bulacağın bilinmez; hep tetikte ol.[ENTER]"
locale.main_quest_flame_lv103.say_47 = "Razadör(6091)'e karşı çıkacağın zamanı Yak-Hwan(20377) söyler.[ENTER]Sen şimdi Kızıl Ejder Kalesi(zone1)'ne gidip Cehennem Ateşi Metini(8057)'ni 1 tane kırıp Yak-Hwan(20377)'e rapor ver.[ENTER]"
locale.main_quest_flame_lv103.say_48 = "Kızıl Ejder Kalesi(zone1)'nde Cehennem Ateşi Metini(8057) kır."
locale.main_quest_flame_lv103.say_49 = "Cehennem Ateşi Metini(8057) kıralım."
locale.main_quest_flame_lv103.say_50 = "Kızıl Ejder Kalesi(zone1)'ndeki Cehennem Ateşi Metini(8057)'ni kır.[ENTER]"
locale.main_quest_flame_lv103.say_51 = "Kalan yıkım sayısı"
locale.main_quest_flame_lv103.say_52 = "Adamım Razadör(6091)'e karşı çıkamaz ama saklanıp keşif yapabilir.[ENTER]Yaşlandım diye beni kandırmaya mı çalışıyorsun?[ENTER]Cehennem Ateşi Metini(8057) kırılmadan sonraki plan yapılamaz; hemen kırıp dön.[ENTER]"
locale.main_quest_flame_lv103.say_53 = "Kızıl Ejder Kalesi(zone1)'ndeki tüm Cehennem Ateşi Metini(8057)'ni kırdın.[ENTER]Yak-Hwan(20377)'e bildir."
locale.main_quest_flame_lv103.say_54 = "Tüm Cehennem Ateşi Metini(8057)'nin kırıldığını duydum.[ENTER]Geleceğini de biliyordum.[ENTER]Eline sağlık. Sonraki planı sen de tahmin edersin.[ENTER]Hemen Razadör(6091)'i yenmek.[ENTER]Hazırlık zaman alır; sonra çağırırsam[ENTER]arındırma sıvısını da alıp gel.[ENTER]"

locale.main_quest_flame_lv104 = {}
locale.main_quest_flame_lv104.say_1 = "Razadör(6091) Seferi 1-2"
locale.main_quest_flame_lv104.say_2 = "Yak-Hwan(20377) seni aceleyle arıyor.[ENTER]Ayrıntıları öğrenmek için Yak-Hwan(20377) ile konuş.[ENTER]"
locale.main_quest_flame_lv104.say_3 = "Uzun bekledin.[ENTER]Cehennem Ateşi Metini(8057)'ni kırdığın için Razadör(6091)'i yenebiliriz artık.[ENTER]Zamanı geldi.[ENTER]İblis Tarikatı'nın komplosunu durdurmak ve Razadör(6091)'i yenmek için çok kayıp verdik;[ENTER]bu sefer mutlaka başarmalıyız.[ENTER]"
locale.main_quest_flame_lv104.say_4 = "Daha önce verdiğim sıvıyı hâlâ tutuyorsun.[ENTER]Adamlarıma damıtılmışını verdim ama seninki saf; etkisi çok büyük.[ENTER]Onu içip Razadör(6091)'i yok et.[ENTER]Saf olsa bile 1 saatten fazla kullanamazsın; uygun zamanda iç.[ENTER]Yoksa Razadör(6091)'e karşı büyük sorun yaşarsın.[ENTER]"
locale.main_quest_flame_lv104.say_5 = "Evet. Anlaşıldı.[ENTER]"
locale.main_quest_flame_lv104.say_6 = "Kızıl Ejder Kalesi(zone1)'nde Razadör(6091)'i yok et."
locale.main_quest_flame_lv104.say_7 = "Razadör(6091)'i yok et."
locale.main_quest_flame_lv104.say_8 = "Kızıl Ejder Kalesi(zone1)'ne girip Razadör(6091)'i yok et.[ENTER]"
locale.main_quest_flame_lv104.say_9 = "※Verilen geçiş kartı yeniden düzenlenmez.[ENTER]"
locale.main_quest_flame_lv104.say_10 = "Razadör(6091) kolay rakip değil.[ENTER]Ama İblis Tarikatı'nın komplosunu durdurup gereksiz katliamı önlemek için[ENTER]mutlaka yenmeliyiz.[ENTER]Tekrar güçlenip git gel.[ENTER]"
locale.main_quest_flame_lv104.say_11 = "Biraz daha olsaydı Kızıl Ejder'in mührünü kaldıracaktım…[ENTER]Bana engel olmak mı…[ENTER]Kızıl Ejder de azgınlaşmak istiyor; beni olduğum gibi öldürmez.[ENTER]Kesin geri döneceğim.[ENTER]"
locale.main_quest_flame_lv104.say_12 = "Kızıl Ejder Kalesi(zone1)'ndeki Razadör(6091)'i yok ettin.[ENTER]Yak-Hwan(20377)'e bildir."
locale.main_quest_flame_lv104.say_13 = "Kötü Ejder Ordusu'ndaki Yak-Hwan(20377)'i bulup konuşalım.[ENTER]"
locale.main_quest_flame_lv104.say_14 = "Harika. Çok harika.[ENTER]Sıradışı olduğunu biliyordum ama Razadör(6091)'i bile yeneceğini…[ENTER]Eline sağlık, git.[ENTER]"
locale.main_quest_flame_lv104.say_15 = "Yak-Hwan(20377), Razadör(6091) ölürken şöyle dedi:[ENTER]Kızıl Ejder azgınlaşmak istiyor; beni olduğum gibi öldürmez ve kesin geri döneceğim, dedi.[ENTER]Galiba bu son değil.[ENTER]"
locale.main_quest_flame_lv104.say_16 = "Anlaşıldı.[ENTER]Bitti sandım ama değilmiş.[ENTER]Daha fazla araştırıp seni çağırırım.[ENTER]"
locale.main_quest_flame_lv104.say_17 = "Komployu Durdurma 1-1"
locale.main_quest_flame_lv104.say_18 = "Hoş geldin.[ENTER]Razadör(6091)'i öldürüp son sözlerini izleyerek çeşitli araştırmalar yaptım.[ENTER]Keşif de gönderdim.[ENTER]Dediğin gibi Razadör(6091) dirilmiş.[ENTER]Üstelik Kızıl Ejder Kalesi(zone1)'nden püsküren kara enerji ve uluma daha şiddetlendi.[ENTER]"
locale.main_quest_flame_lv104.say_19 = "Herhâlde Razadör(6091)'i yeniden yok edip mühür basmalıyız ki rahat edelim.[ENTER]Daha güçlenen rakiple uğraşmak az kayıp getirmez.[ENTER]Zahmet olacak ama bu konuyu Yon-I Gezgini(20380)'e de bildirdim; ona gidip ayrıntıları dinle.[ENTER]"
locale.main_quest_flame_lv104.say_20 = "Yon-I Gezgini(20380)'e gidip planı dinle."
locale.main_quest_flame_lv104.say_21 = "Yon-I Gezgini(20380)'e gidelim."
locale.main_quest_flame_lv104.say_22 = "Yon-I Gezgini(20380)'e gidip planı dinleyelim.[ENTER]"
locale.main_quest_flame_lv104.say_23 = "Yon-I Gezgini(20380)'e git dedim, niye geri geldin…[ENTER]Hemen git.[ENTER]"
locale.main_quest_flame_lv104.say_24 = "Hoş geldin. Seni bekliyordum.[ENTER]Geçenlerde Razadör(6091)'i yenmişsin.[ENTER]Sıradışı bir güç taşıyorsun; iyi yapacağını düşündüm ama harika.[ENTER]Önce planı anlatayım.[ENTER]"
locale.main_quest_flame_lv104.say_25 = "Razadör(6091)'in Kızıl Ejder'in gücüyle dirildiği doğru.[ENTER]O gücü kesmek için Kızıl Ejder'e doğrudan mühür basmak en verimlisi.[ENTER]Bu yüzden mühür basma yöntemi buldum; bana yardım edip uygularsan olur.[ENTER]"
locale.main_quest_flame_lv104.say_26 = "Anlaşıldı. Nasıl yardım edebilirim?[ENTER]"
locale.main_quest_flame_lv104.say_27 = "Geçenlerde yin-yang beş elementin mantığını kısaca anlattım; yin ve yang'ı öğrendin.[ENTER]Ama her nitelik aşırıya ulaşınca daha fazla güç göstermez, kontrol edilemez olur.[ENTER]Bu yüzden yang'ı yang'la bastırma yöntemi düşündüm.[ENTER]Bu yöntemi uygulamak için yang niteliği güçlü bir tür çekirdek gerek.[ENTER]Araştırmam sonucu kaliteli çekirdek için Kor Alev Kralı(6005), Kor Alev Sakallısı(6007), Kor Ateş Golemi(6006), Kor Alev Generali(6008), Kor Alev Lordu(6009) bu yaratıkları öldürüp çekirdek getirmelisin.[ENTER]Bu işi yapacak tek kişi sensin; lütfen 5'er çekirdek getir.[ENTER]"
locale.main_quest_flame_lv104.say_28 = "Mühür için gereken malzemeyi bulalım."
locale.main_quest_flame_lv104.say_29 = "Mühür için gereken malzemeyi bulup Yon-I Gezgini(20380)'e ver.[ENTER]"
locale.main_quest_flame_lv104.say_30 = "Oh~bu kadarı yeterli.[ENTER]Şimdi %d tane daha getirirsen olur.[ENTER]Biraz daha gayret.[ENTER]"
locale.main_quest_flame_lv104.say_31 = "Çekirdekler tamam.[ENTER]Ama bunlar dışında gerekli malzeme daha var.[ENTER]Önce bu çekirdekleri damıtıp haber veririm; dinlen.[ENTER]"
locale.main_quest_flame_lv104.say_32 = "Hmm…zorlukla getirdin ama bu çekirdek çok düşük sıcaklıkta; kullanılamaz.[ENTER]Başkasını getirir misin?[ENTER]"
locale.main_quest_flame_lv104.say_33 = "Komployu Durdurma 1-2"
locale.main_quest_flame_lv104.say_34 = "Yon-I Gezgini(20380) seni aceleyle arıyor.[ENTER]Ayrıntıları öğrenmek için Yon-I Gezgini(20380) ile konuş.[ENTER]"
locale.main_quest_flame_lv104.say_35 = "Magma Çemberi(31082)'ni getirdikten sonra damıtma işi sürüyor.[ENTER]Çok sıcak; benim gibi güçsüz bir Yon-I Gezgini(20380) için bile zor.[ENTER]Bu yüzden elim de yandı.[ENTER]Durum böyle; sonraki malzemeyi söyleyeyim.[ENTER]Bu sefer getireceğin Dok-Suyu(50814).[ENTER]"
locale.main_quest_flame_lv104.say_36 = "Dok-Suyu(50814), damıtılmış çekirdeği üstüne koyup buharla eritmekte kullanılır.[ENTER]O tamamlanınca mühür başlayabilir.[ENTER]Yöntemi sonra Yak-Hwan(20377)'den öğrenirsin; Dok-Suyu(50814) çok gerekli, 100 kadar getir.[ENTER]Bekliyorum.[ENTER]"
locale.main_quest_flame_lv104.say_37 = "Dok-Suyu(50814) bulup Yon-I Gezgini(20380)'e ver."
locale.main_quest_flame_lv104.say_38 = "Dok-Suyu(50814) bulup Yon-I Gezgini(20380)'e ver.[ENTER]"
locale.main_quest_flame_lv104.say_39 = "Getirdin mi.[ENTER]Şimdi buharla eritirsek neredeyse tamamlanır.[ENTER]Eline sağlık.[ENTER]"
locale.main_quest_flame_lv104.say_40 = "Neredeyse mi?[ENTER]Hâlâ kalan var mı?[ENTER]"
locale.main_quest_flame_lv104.say_41 = "Son kaldı.[ENTER]Eritme işi dikkat ister; sonra tekrar çağırırım.[ENTER]"
locale.main_quest_flame_lv104.say_42 = "Sakın sayı saymayı bilmiyor olma?[ENTER]Ne kadar savaşçı olsan da 100'e kadar saymalısın…tık tık[ENTER]Hemen gidip kalan Dok-Suyu(50814)'ü de getir.[ENTER]"
locale.main_quest_flame_lv104.say_43 = "Dok-Suyu(50814)'ün hepsini getirdin. Yon-I Gezgini(20380)'e ver."
locale.main_quest_flame_lv104.say_44 = "Kötü Ejder Ordusu'ndaki Yon-I Gezgini(20380)'ni bulup konuşalım.[ENTER]"
locale.main_quest_flame_lv104.say_45 = "Komployu Durdurma 1-3"
locale.main_quest_flame_lv104.say_46 = "Bana yardım ettiğin için hazırlıklar yolunda gidiyor.[ENTER]Son düzlükteyiz; biraz daha gayret.[ENTER]Son aşama.[ENTER]"
locale.main_quest_flame_lv104.say_47 = "Şimdi bitiş, bu damıtılmış sıvıyı tam tutacak bir kap yapmak.[ENTER]Şu anki madde yang enerjisi taştığından çok dengesiz.[ENTER]Etkisi garanti ama.[ENTER]Konuya gelelim; sen İblis Tarikatı'nı takip ederken Martyaxwar kabilesiyle uğraştın.[ENTER]Kabile içindeki Martyaxwar(3291)'den deri getir.[ENTER]Kat kat sarmak gerek; 5 tane getir.[ENTER]"
locale.main_quest_flame_lv104.say_48 = "Kaliteli deri bulup Yon-I Gezgini(20380)'e ver."
locale.main_quest_flame_lv104.say_49 = "Mantikor Derisi(31024) bulup Yon-I Gezgini(20380)'e ver.[ENTER]"
locale.main_quest_flame_lv104.say_50 = "Şimdi bitiş; gayret edip hepsini getir.[ENTER]İblis Tarikatı ve Kızıl Ejder'i durdurmalıyız.[ENTER]Bekliyorum.[ENTER]"
locale.main_quest_flame_lv104.say_51 = "Oh~tüm malzeme tamam.[ENTER]Biraz bekle.[ENTER]Hemen işleyip veririm; sonra Yak-Hwan(20377) çağırırsa götür.[ENTER]"
locale.main_quest_flame_lv104.say_52 = "Derinin hepsini getirdin. Yon-I Gezgini(20380)'e ver."

locale.main_quest_flame_lv105 = {}
locale.main_quest_flame_lv105.say_1 = "Çetin Savaşın Başlangıcı"
locale.main_quest_flame_lv105.say_2 = "Yak-Hwan(20377) seni aceleyle arıyor.[ENTER]Ayrıntıları öğrenmek için Yak-Hwan(20377) ile konuş.[ENTER]"
locale.main_quest_flame_lv105.say_3 = "Uzun zaman oldu.[ENTER]Yon-I Gezgini(20380)'e yardım edip mühür malzemesini yapmışsın.[ENTER]Mühür Kesesi(31083)'ni getirdin mi?[ENTER]"
locale.main_quest_flame_lv105.say_4 = "Buyrun. Toplam 3 tane.[ENTER]"
locale.main_quest_flame_lv105.say_5 = "Mühür Kesesi(31083)'nin kullanımını sonra anlatırım.[ENTER]Önce yapman gerekeni söyleyeyim.[ENTER]Mühür Kesesi(31083) tamamlandı ama bildiğin gibi Kızıl Ejder'in etkisiyle Razadör(6091) bile dirildi.[ENTER]Çok zor bir durum.[ENTER]Bu sefer doğrudan emrimdeki İblis Yok Etme Ordusu'nun yarısını operasyona sokacağım.[ENTER]"
locale.main_quest_flame_lv105.say_6 = "Kızıl Ejder Kalesi(zone1)'ndeki yaratıkları askerlerimle biraz temizleyebiliriz.[ENTER]Ama komuta yaratıklarından Razadör(6091)'e kadar askerlerimin kaldıramayacağı kadar[ENTER]büyük bir duvar gibi.[ENTER]Önce komuta yaratıkları Kor Alev Kralı(6005), Kor Alev Sakallısı(6007), Kor Ateş Golemi(6006), Kor Alev Generali(6008), Kor Alev Lordu(6009)'u 10'ar temizle dön.[ENTER]"
locale.main_quest_flame_lv105.say_7 = "Evet. Anlaşıldı.[ENTER]"
locale.main_quest_flame_lv105.say_8 = "Kızıl Ejder Kalesi(zone1)'ne girip komuta yaratıklarını yok et."
locale.main_quest_flame_lv105.say_9 = "Komuta kademesini yok edelim."
locale.main_quest_flame_lv105.say_10 = "Kızıl Ejder Kalesi(zone1)'ne girip komuta yaratıklarını öldür.[ENTER]"
locale.main_quest_flame_lv105.say_11 = "※Verilen geçiş kartı yeniden düzenlenmez.[ENTER]"
locale.main_quest_flame_lv105.say_12 = "Komuta kademesini yeterince yok etmemişsin galiba.[ENTER]Komuta yok edilmezse Kızıl Ejder'e mühür de İblis Tarikatı da yapılamaz.[ENTER]Hemen git gel.[ENTER]"
locale.main_quest_flame_lv105.say_13 = "Kızıl Ejder Kalesi(zone1) komuta yaratıklarının hepsini öldürdün.[ENTER]Yak-Hwan(20377)'e rapor ver."
locale.main_quest_flame_lv105.say_14 = "Kötü Ejder Ordusu'ndaki Yak-Hwan(20377)'i bulup konuşalım.[ENTER]"
locale.main_quest_flame_lv105.say_15 = "Artık Kızıl Ejder Kalesi(zone1)'ne girip İblis Tarikatı'nın komplosunu durdurabiliriz.[ENTER]Şimdi sadece Kızıl Ejder'e mühür basmak kaldı.[ENTER]Eline sağlık.[ENTER]"
locale.main_quest_flame_lv105.say_16 = "Kin"
locale.main_quest_flame_lv105.say_17 = "Komutayı yok ettiğin ve daha önce Razadör(6091)'i öldürdüğün için dirilen Razadör(6091) çok öfkeli görünüyor.[ENTER]Kızıl Ejder Kalesi(zone1)'nde uluması yankılanıyor diye rapor geldi.[ENTER]Razadör(6091) sana düşman oldu; doğal.[ENTER]Yine de çok fark etmez.[ENTER]"
locale.main_quest_flame_lv105.say_18 = "Bu sefer yapacağın işi tahmin edersin: Razadör(6091)'i öldürmek.[ENTER]Daha önce de öldürdün ama Kızıl Ejder yüzünden dirildi ve sana kin besliyor;[ENTER]dikkatli ol.[ENTER]Kolay yaptığın işi bile gevşeklik bozar; unutma git.[ENTER]"
locale.main_quest_flame_lv105.say_19 = "Kızıl Ejder Kalesi(zone1)'nde Razadör(6091)'i yok et."
locale.main_quest_flame_lv105.say_20 = "Razadör(6091)'i cezalandıralım."
locale.main_quest_flame_lv105.say_21 = "Kızıl Ejder Kalesi(zone1)'ne girip Razadör(6091)'i öldür.[ENTER]"
locale.main_quest_flame_lv105.say_22 = "Razadör(6091) korkuttu mu seni?[ENTER]Hemen gidip Razadör(6091)'i öldür gel.[ENTER]Sen yapabilirsin.[ENTER]"
locale.main_quest_flame_lv105.say_23 = "Kızıl Ejder Kalesi(zone1)'ndeki Razadör(6091)'i yok ettin.[ENTER]Yak-Hwan(20377)'e bildir."
locale.main_quest_flame_lv105.say_24 = "İşte!!Yine harika.[ENTER]Eline sağlık.[ENTER]Adamımdan az önce rapor aldım.[ENTER]Şimdi Kızıl Ejder'e doğrudan mühür basarsak biraz hallolur.[ENTER]Askerleri düzenleyip tekrar çağırırım.[ENTER]"
locale.main_quest_flame_lv105.say_25 = "Kızıl Ejder'in Mührü"
locale.main_quest_flame_lv105.say_26 = "Sonunda zaman geldi.[ENTER]Kızıl Ejder'e mühür basıp İblis Tarikatı'nın komplosunu durdurma zamanı.[ENTER]Şimdi Mühür Kesesi(31083)'nin kullanımı ve yapılacakları anlatayım.[ENTER]"
locale.main_quest_flame_lv105.say_27 = "Daha önce bana verdiğin Mühür Kesesi(31083)'ni adamlarımla 2 noktaya kurup düzen kurdum.[ENTER]Mühür Kesesi(31083)'nin içindekiyle düzen kurulur ve kullanımına göre şiddetli patlayıcı olur.[ENTER]Senin yapacağın patlamayı sağlamak.[ENTER]Razadör(6091)'i öldürdüğün yerde Kızıl Ejder'in mühürlü olduğu yer görünür.[ENTER]Oraya Mühür Kesesi(31083)'ni güçlü at.[ENTER]Kesenin içi dengesiz olduğundan patlama olur ve adamlarımın kurduğu düzen sayesinde[ENTER]mühür devreye girer.[ENTER]"
locale.main_quest_flame_lv105.say_28 = "Kızıl Ejder Kalesi(zone1)'ne girip Kızıl Ejder'e mühür bas."
locale.main_quest_flame_lv105.say_29 = "Kalan mühür sayısı"
locale.main_quest_flame_lv105.say_30 = "Kızıl Ejder'e mühür bas."
locale.main_quest_flame_lv105.say_31 = "Kızıl Ejder Kalesi(zone1)'ne girip Kızıl Ejder mühür taşına Mühür Kesesi(31083) kullan.[ENTER]"
locale.main_quest_flame_lv105.say_32 = "Taramor Mezar Taşı(20390): 1 adet"
locale.main_quest_flame_lv105.say_33 = "Kızıl Ejder Öfkesi"
locale.main_quest_flame_lv105.say_34 = "Grrr…zi..zorla bu kadar mı!! Kahahaha[ENTER]Beklenmedik şekilde çok güç kaybettim ama bu kadarıyla bana mühür basamazsın.[ENTER]Ben de Razadör(6091) de dirilip mührü kıracağız.[ENTER]Kahahahaha[ENTER]"
locale.main_quest_flame_lv105.say_35 = "Kızıl Ejder'e mühür basmaya çalıştın ama başarısız oldu.[ENTER]Yak-Hwan(20377)'e bildir."
locale.main_quest_flame_lv105.say_36 = "Hoş geldin. Kabaca duydum ama ayrıntıları bana anlat.[ENTER]"
locale.main_quest_flame_lv105.say_37 = "Evet.[ENTER]Düzenin çalışması ve patlama doğru oldu.[ENTER]Elbette mühür denemesi de oldu.[ENTER]Ama Kızıl Ejder'in devasa gücüyle mühür başarısız oldu.[ENTER]Kızıl Ejder, Razadör(6091)'i de dirilteceğini ve kendisinin de mührü kıracağını söyledi.[ENTER]Ama bu mühür denemesi beklenmedik oldu; büyük zarar verdi.[ENTER]"
locale.main_quest_flame_lv105.say_38 = "Öyle mi.[ENTER]Eline sağlık. Senin sayende buraya kadar geldik.[ENTER]Raporu aldıktan sonra stratejistleri ve Yon-I Gezgini(20380)'ni toplayıp buna karşı önlem almak istedim.[ENTER]Şu an adamlarımla sürekli gözetleme yapıp doğrudan mühür basma yolunu bulmam gerek.[ENTER]Kızıl Ejder'e mühür basıp tam mühürleme yolunu bulursam seni tekrar çağırırım.[ENTER]Eline sağlık.[ENTER]"

locale.snow_dungeon = {}
locale.snow_dungeon.say_1 = "Kara Ejder zindanı başlangıç istihbaratı"
locale.snow_dungeon.say_2 = "Süre doldu.[ENTER] Kara Ejder istihbarat pozisyonu 1 saat korunur ve Beyaz Ejder ilerlemesinin ortasına gönderilir; pozisyon 30 dakikayla sınırlıysa tamamlanır."
locale.snow_dungeon.say_3 = "geçemezsen zindandan dışarı atılırsın."
locale.snow_dungeon.say_4 = "10 saniye sonra boss odasına gidiliyor"
locale.snow_dungeon.say_5 = "Beyaz Ejder istihbaratı"
locale.snow_dungeon.say_6 = "Kara Ejder zindanına gerçekten girmek istiyor musun?"
locale.snow_dungeon.say_7 = "İkinci kata geçmeye 10 saniye"
locale.snow_dungeon.say_8 = "Dördüncü kata geçmeye 10 saniye"
locale.snow_dungeon.say_9 = "Beşinci kata geçmeye 10 saniye"
locale.snow_dungeon.say_10 = "Metin taşları bulundu"
locale.snow_dungeon.say_11 = "Üçüncü kata geçmeye 10 saniye"
locale.snow_dungeon.say_12 = "gerçek anahtar değil"
locale.snow_dungeon.say_13 = "Lütfen ikinci büyüyü kaldırın"
locale.snow_dungeon.say_14 = "Lütfen üçüncü büyüyü kaldırın"
locale.snow_dungeon.say_15 = "yanlış sıra"
locale.snow_dungeon.say_16 = "Lütfen dördüncü zincirleri kurun"
locale.snow_dungeon.say_17 = "Lütfen beşinci zincirleri kurun"
locale.snow_dungeon.say_18 = "Altıncı kata geçmeye 10 saniye"
locale.snow_dungeon.say_19 = "Yedinci kata geçmeye 10 saniye"
locale.snow_dungeon.say_20 = "yanlış, yok oluyor"
locale.snow_dungeon.say_21 = "Sekizinci kata geçmeye 10 saniye"
locale.snow_dungeon.say_22 = "Dokuzuncu kata geçmeye 10 saniye"
locale.snow_dungeon.say_23 = "Boss yenildi"
locale.snow_dungeon.say_24 = "1 dakika sonra Kara Ejder istihbaratı dışarı hareket eder."
locale.snow_dungeon.say_25 = "Pozisyon süresi doldu; Beyaz Ejder zihni koruma moduna geçecek."
locale.snow_dungeon.say_26 = "Kara Ejder istihbaratı kalış süresi girişi %d dakika."
locale.snow_dungeon.say_27 = "Kara Ejder istihbarat pozisyonları tutma süresi doldu."
locale.snow_dungeon.say_28 = "10 saniye sonra Kara Ejder istihbaratı sönüyor."
locale.snow_dungeon.say_29 = "Tekrar giriş süresi beş dakikadan fazlaysa izin verilmez.[ENTER]"
locale.snow_dungeon.say_30 = "Parti engellendiği için ilerleyemez; yok oluyor[ENTER]"
locale.snow_dungeon.say_31 = "Parti üyeleri 104Lv olmadığı için ilerlemek imkânsız."
locale.snow_dungeon.say_32 = "Parti üyeleri 103Lv ve tüm görevleri tamamlamadı; ilerlemek imkânsız."
locale.snow_dungeon.say_33 = "Nemere kararı: bu pozisyonu istiyor musun?"
locale.snow_dungeon.say_34 = "pozisyon"
locale.snow_dungeon.say_35 = "Kapat"
locale.snow_dungeon.say_36 = "Boss Odasına Giriş"
locale.snow_dungeon.say_37 = "tüm kötülüğü yenmek için."
locale.snow_dungeon.say_38 = "buzdaki kötülüğün anahtarı."
locale.snow_dungeon.say_39 = "tüm kötülüğü yenip mührü kırmak."
locale.snow_dungeon.say_40 = "tüm mühürleri kırmak için."
locale.snow_dungeon.say_41 = "İptal için gereken öğeler kötülükten elde edilebilir."
locale.snow_dungeon.say_42 = "Buz Mana Taşı'nı tüm canavarları yenerek yok et."
locale.snow_dungeon.say_43 = "mühür taşı verildi."
locale.snow_dungeon.say_44 = "Kötülük, Beyaz Ejder kullanılarak elde edildi."
locale.snow_dungeon.say_45 = "Beyaz Ejder Çarkı'nı yok etmek için."
locale.snow_dungeon.say_46 = "Nemere'ye verildi."
locale.snow_dungeon.say_47 = "zindanı parti ile başlatamadı veya başarısız oldu"

locale.event_flame_dungeon_open = {}
locale.event_flame_dungeon_open.say_1 = "Alev Toprakları'ndaki Kargaşa"
locale.event_flame_dungeon_open.say_2 = "Ah.. haberi duydun mu..[ENTER]Alev Toprakları'nda büyük bir kalıntı bulunmuş...[ENTER]Keşke ben de senin gibi bir savaşçı olsaydım....[ENTER]O kalıntıyı bizzat görmek isterdim ama gücüm yetmez..."
locale.event_flame_dungeon_open.say_3 = "Hmm.... biraz sonra tekrar gelirsen...[ENTER]Alev Toprakları kalıntısının koordinatları yazılı bir ışınlanma belgesi veririm...[ENTER]Onunla gidip bana anlatır mısın?![ENTER]Çok merak ediyorum.... he he" 
locale.event_flame_dungeon_open.say_4 = "Işınlanma belgesini verin~!"
locale.event_flame_dungeon_open.say_5 = "Oho~!![ENTER]Cesur ve harika birisin...[ENTER]Vahşi ve yaratık dolu Alev Toprakları'na böyle gitmek[ENTER]sıradan yürekli olmayan için imkânsız..[ENTER]Bakalım...."
locale.event_flame_dungeon_open.say_6 = "Al bakalım~!!![ENTER]İşte burada~!! Alev Toprakları kalıntısının koordinatları kayıtlı ışınlanma belgesi[ENTER]Üstüne bir de geçiş kartı veriyorum; iyice bak ve dönünce bana anlat~![ENTER]Kendine iyi bak~!!"
locale.event_flame_dungeon_open.say_7 = "Ahem~!!![ENTER]Bu adam~!! Ne kadar ben olsam da ışınlanma belgesi yapmanın bir sınırı var...[ENTER]Günde sadece bir kez verebilirim; yarın gel..."
