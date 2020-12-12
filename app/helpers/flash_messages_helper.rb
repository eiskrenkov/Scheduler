module FlashMessagesHelper
  FLASH_MESSAGES_CLASS_MAPPING = {
    alert: 'alert-danger', notice: 'alert-success'
  }.freeze

  def render_flash_message
    message_to_present = flash.to_h.symbolize_keys.slice(:alert, :notice).first
    return unless message_to_present

    flash_class = "alert alert-dismissible fade show #{FLASH_MESSAGES_CLASS_MAPPING.fetch(message_to_present.first)}"

    tag.div(class: flash_class) do
      safe_join(
        [
          message_to_present.second,
          tag.button(fa_icon('times'), class: 'close', data: { dismiss: 'alert' })
        ]
      )
    end
  end
end
