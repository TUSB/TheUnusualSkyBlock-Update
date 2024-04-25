# スキルデータ再読み込み
function skill:data/

# SkillDisplayの削除
kill @e[tag=SkillDisplay]

# 脅威島のブロック修正
execute in area:skylands run forceload add 39 -556
schedule function settings:version_update/v13_2_2_alpha2/schedule 1t
