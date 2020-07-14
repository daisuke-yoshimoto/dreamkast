require 'rails_helper'

RSpec.describe Profiles::TalksController, type: :request do
  subject(:session) { {userinfo: {info: {email: "foo@example.com", extra: {sub: "aaa"}}, extra: {raw_info: {sub: "aaa", "https://cloudnativedays.jp/roles" => roles}}} } }
  let(:roles) { [] }

  describe "GET /:event/profiles/talks" do
    describe "logged in and registered" do
      before do
        create(:alice)
        allow_any_instance_of(ActionDispatch::Request).to receive(:session).and_return(session)
      end

      context "user is admin" do
        let(:roles) { ["CNDT2020-Admin"] }

        it "return a success response" do
          get '/cndt2020/profiles/talks'
          expect(response).to be_successful
          expect(response).to have_http_status '200'
        end

        it "link to admin is displayed" do
          get '/cndt2020/profiles/talks'
          expect(response.body).to include('<a class="dropdown-item" href="/admin">管理画面</a>')
        end
      end

      context "user is not admin" do
        it "return a success response" do
          get '/cndt2020/profiles/talks'
          expect(response).to be_successful
          expect(response).to have_http_status '200'
        end

        it "link to admin is not displayed" do
          get '/cndt2020/profiles/talks'
          expect(response.body).to_not include('<a class="dropdown-item" href="/admin">管理画面</a>')
        end
      end
    end
  end
end