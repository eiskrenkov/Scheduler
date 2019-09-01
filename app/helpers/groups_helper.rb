module GroupsHelper
  def groups_for_select
    content_tag(:ul, class: 'nav nav-pills nav-fill') do
      groups = Group.all.map do |group|
        content_tag(:li, class: 'nav-item') do
          css = 'nav-link ' + (cookies[:group_id].to_i == group.id ? 'active' : '')
          link_to(group.name, dashboard_set_group_path(group_id: group.id), method: :post, class: css)
        end
      end

      safe_join(groups)
    end
  end

  def current_group
    Group.find_by(id: cookies[:group_id].to_i) || Group.first
  end
end
