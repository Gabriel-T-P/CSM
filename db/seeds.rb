puts "\n== Creating admin account =="

default_password = '12345678'

admin = User.find_or_create_by!(email: 'master@email.com') do |user|
  user.first_name = 'Master'
  user.last_name  = 'Admin'
  user.username   = 'Master'
  user.password   = default_password
  user.password_confirmation = default_password
  user.role       = :admin
  user.biography  = 'This account has the privileges of an Admin'
  user.birth_date = 30.years.ago
  user.gender     = :male
  user.location   = 'Toronto, Canada'
end.tap do |user|
  avatar_path = Rails.root.join("app/assets/images/master_avatar.png")
  user.avatar.attach(
    io: File.open(avatar_path),
    filename: "master_avatar.png",
    content_type: "image/png"
  ) unless user.avatar.attached?
end

puts "\n== Creating regular user =="

user = User.find_or_create_by!(email: 'user1@email.com') do |u|
  u.first_name = 'Alice'
  u.last_name  = 'Smith'
  u.username   = 'User_1'
  u.password   = default_password
  u.password_confirmation = default_password
  u.role       = :regular
  u.biography  = 'Just a regular user exploring the platform!'
  u.birth_date = 25.years.ago
  u.gender     = :female
  u.location   = 'São Paulo, Brazil'
end.tap do |u|
  avatar_path = Rails.root.join("app/assets/images/default_avatar.png")
  u.avatar.attach(
    io: File.open(avatar_path),
    filename: "default_avatar.png",
    content_type: "image/png"
  ) unless u.avatar.attached?
end

puts "\n== Creating tags =="

['Tag One', 'Tag Two', 'Tag Three', 'Tag Four'].each do |name|
  Tag.find_or_create_by!(name: name)
end

puts "\n== Creating announcements =="

Announcement.find_or_create_by!(title: 'Announcement 1') do |a|
  a.body     = 'Description test'
  a.start_at = 1.day.ago
  a.end_at   = 5.days.from_now
end

Announcement.find_or_create_by!(title: 'Announcement 2') do |a|
  a.body     = 'Description test'
  a.start_at = 1.day.ago
  a.end_at   = 5.months.from_now
end

puts "\n== Creating example contents =="

tags = Tag.all.to_a
visibilities = %w[visible_to_all only_me unlisted]

default_cover_path = Rails.root.join("app/assets/images/sample_cover.jpg")

[
  { user: admin, title: "Admin’s Guide to the Platform" },
  { user: user, title: "My First Post on the Platform" },
  { user: user, title: "Thoughts on Ruby on Rails" },
  { user: user, title: "Designing a Better Web App" }
].each do |data|
  content = Content.find_or_create_by!(title: data[:title], user: data[:user]) do |c|
    c.body       = <<~HTML
                      <h1>Lorem Ipsum Dolor Sit Amet</h1>
                      <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>

                      <h2>Consectetur Adipiscing Elit</h2>
                      <p>Nullam in diam nec est volutpat tempor. <strong>Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas.</strong> Mauris consectetur, libero eu dapibus varius, enim leo malesuada nisl, in finibus leo ipsum non velit. <em>Proin ut purus vitae ligula efficitur iaculis.</em></p>

                      <h3>Sectione Proin Vitae</h3>
                      <ul>
                        <li>Phasellus ullamcorper felis in purus convallis.</li>
                        <li>Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae.</li>
                        <li>Donec consectetur elit vel felis facilisis.</li>
                        <li>Nam in ipsum sed orci consequat tempus.</li>
                      </ul>

                      <p>Quisque non nulla at nulla efficitur tincidunt. Suspendisse potenti. Integer tincidunt erat eu dolor fringilla, ut tempor odio facilisis. Aenean quis neque nec sem faucibus efficitur. Sed nec felis sit amet nulla blandit cursus at vel odio. Fusce vel nisi vitae ligula efficitur iaculis. Nulla facilisi.</p>

                      <h4>Praesent Non Dolor</h4>
                      <ol>
                        <li>Morbi eget felis non neque ullamcorper.</li>
                        <li>Sed vel purus a magna auctor.</li>
                        <li>Curabitur non ipsum in neque egestas.</li>
                      </ol>

                      <p>Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec eu elit vel ex maximus tincidunt. Fusce bibendum, lectus vitae elementum iaculis, lacus orci efficitur arcu, a consequat purus eros vel nulla. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Vivamus eu nisi in massa iaculis interdum.</p>
                    HTML
    c.visibility = visibilities.sample
    c.tag_ids    = tags.sample(rand(1..3)).map(&:id)
  end

  unless content.cover.attached?
    content.cover.attach(
      io: File.open(default_cover_path),
      filename: "sample_cover.jpg",
      content_type: "image/jpeg"
    )
  end
end
