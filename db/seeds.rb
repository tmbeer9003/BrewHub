# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Admin.create!(
  [
    email: "admin@test.com",
    password: "test2022",
    account_name: "admin"
  ]
)

Member.create!(
  [
    {email: 'taro@test.com', password: 'test2022', account_name: 'test1', display_name: 'ビール太郎', date_of_birth: '2000-01-01', member_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user1.jpg"), filename:"sample-user1.jpg")},
    {email: 'hanako@test.com', password: 'test2022', account_name: 'test2', display_name: 'ビール花子', date_of_birth: '2000-02-02', member_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user2.jpg"), filename:"sample-user2.jpg")},
  ]
)

BeerStyle.create!(
  [
    {name: 'ヘイジーIPA', category: 1},
    {name: 'セゾン', category: 1},
    {name: 'バーレーワイン', category: 1},
    {name: 'ヘイジーダブルIPA', category: 1}
  ]
)

Brewery.create!(
  [
    {name: 'サンクトガーレン', location: 14},
    {name: 'VERTERE', location: 13},
    {name: '麦雑穀工房', location: 11},
    {name: 'ヤッホーブルーイング', location: 20},
    {name: 'WEST COAST BREWING', location: 22}
  ]
)

Beer.create!(
  [
    {beer_style_id: 1, brewery_id: 1, name: 'SPACE HAZY', abv: '7.0'},
    {beer_style_id: 2, brewery_id: 2, name: 'Ruta', abv: '6.0', ibu: '15'},
    {beer_style_id: 1, brewery_id: 3, name: 'CIA', abv: '7.0'},
    {beer_style_id: 3, brewery_id: 4, name: 'ハレの日仙人2020', abv: '10.5'},
    {beer_style_id: 4, brewery_id: 5, name: 'WINDOW TO VERTERE', abv: '8.0'},
  ]
)

Post.create!(
  [
    {member_id: 1, beer_id: 1, content: 'グレフル強めグラッシーなヘイジー。苦味強め。', evaluation: '4.0', serving_style: '0', post_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post1.jpg"), filename:"sample-post1.jpg")},
    {member_id: 1, beer_id: 2, content: 'マスカット、洋梨のジューシーさからのレモンの酸味。香りはちょっとバナナ。若干水っぽい。', evaluation: '4.5', serving_style: '0', post_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post2.jpg"), filename:"sample-post2.jpg")},
    {member_id: 1, beer_id: 3, content: 'オレンジ強め。そこそこアルコール感を感じる。後味にバニラくっきり。', evaluation: '4.5', serving_style: '2', post_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post3.jpg"), filename:"sample-post3.jpg")},
    {member_id: 2, beer_id: 4, content: '黒糖みたいなカラメル感。そんなに重たくない。', evaluation: '4.0', serving_style: '2', post_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post4.jpg"), filename:"sample-post4.jpg")},
    {member_id: 2, beer_id: 5, content: 'トロピカルシトラス松。お手本的ヘイジー。', evaluation: '5.0', serving_style: '1', post_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post5.jpg"), filename:"sample-post5.jpg")}
  ]
)

Group.create!(
  [
    {owner_id: 1, name: 'IPA好き集合！', description: 'IPA好きの人、語り合いましょう！'}
  ]
)

GroupsMember.create!(
  [
    {group_id: 1, member_id: 1}
  ]
)
