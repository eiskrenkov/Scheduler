module GroupsHelper
  def groups_for_select
    content_tag(:ul, class: 'nav nav-pills nav-fill') do
      groups = collection.map.with_index do |group, index|
        content_tag(:li, class: 'nav-item') do
          link_to(
            group.name, dashboard_set_group_path(group_id: group.id),
            method: :post, class: group_pill_class(group, index)
          )
        end
      end

      safe_join(groups)
    end
  end

  def current_group
    Group.find_by(id: cookies[:group_id].to_i) || Group.first
  end

  private

  def group_pill_class(group, index)
    ['nav-link', ('active' if append_active?(group, index))].join(' ')
  end

  def append_active?(group, index)
    cookies[:group_id].blank? && index.zero? || cookies[:group_id].to_i == group.id
  end
end
