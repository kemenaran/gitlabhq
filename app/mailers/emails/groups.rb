module Emails
  module Groups
    def group_access_granted_email(group_member_id)
      @group_member = GroupMember.find(group_member_id)
      @group = @group_member.group
      @target_url = group_url(@group)
      mail(cc: @group_member.user.email,
           subject: subject("Access to group was granted"))
    end
  end
end
