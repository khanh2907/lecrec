class ResqueAccessConstraints
  def matches?(request)
    current_user = request.env['warden'].user
    unless current_user.present? and current_user.is_admin?
      #raise CanCan::AccessDenied
      #request.env["warden"].authenticate!
      return false
    end
    return true
  end
end