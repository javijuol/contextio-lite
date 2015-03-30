# Contextio::Lite

This is API client for the [Context.IO Lite](https://context.io/) version based on [Context.IO Ruby](https://github.com/contextio/contextio-ruby) for the 2.0 version.
It works in the same way as the official, calling first a user object and then working with the collections...

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'contextio-lite'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install contextio-lite

## Usage

### Get a client

```ruby
require 'contextio'

client = ContextIO.lite(API_KEY, API_SECRET)
```

### Dealing with users

List all the registered lite users IDs

```ruby
p client.users.map(&:id)
```

CRUD

```ruby
user = client.users.create email: 'bob@gmail.com', first_name: 'Bob', server: 'imap.gmail.com' username: 'bob', use_sll:true, port: 993, type: 'IMAP'

user_id = user.id

client.users[user_id].update :hash_attrs

client.users[user_id].delete
```

### Retrieving messages

To access the emails, first you need to select an email_account and the folder containing your email

So if you want to list the user email accounts or folders you can do like this

```ruby
p client[user_id].email_accounts.map(&:label)
p client[user_id].email_accounts[label].folders.map(&:name) # can access email_accounts by number => email_accounts[0]
```

Listing all the email subjects inside a folder (limited by context IO to 100)
```ruby
client[user_id].email_accounts[0].folders['INBOX'].messages do
    p messages.subject
end
```

And if you want to filter the emails

```ruby
client[user_id].email_accounts[0].folder['INBOX'].messages.where(limit: 3)
```

You also may want to access the content of one message

```ruby
client[user_id].email_accounts[0].folder['INBOX'].messages['<message_id>'].body_plain # or body_html

client[user_id].email_accounts[0].folder['INBOX'].messages['<message_id>'].with(include_body:true).body_plain
```

The first one calls https://api.context.io/lite/users/id/email_accounts/label/folders/folder/messages/message_id/body
and the second calls https://api.context.io/lite/users/id/email_accounts/label/folders/folder/messages/message_id?include_body=1
but they return the same.

And the above should works also with 'flags' or 'headers'.

### Webhooks

One of the main feature that this version has and 2.0 doesn't is the real-time webhooks.
So in order to work with them we can do

```ruby
client[user_id].webhooks.map(&:webhook_id) # listing all the webhooks an user has

client[user_id].create callback_url, failure_url, filter_folder_added: 'INBOX', include_body: true
```

So it will call the callback_url every time there is a new message on the user INBOX folder, posting the message info and body included.


## Contributing

1. Fork it ( https://github.com/javijuol/contextio-lite/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Copyright

This gem is distributed under the MIT License. See LICENSE.md for details.
